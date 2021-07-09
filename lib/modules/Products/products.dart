import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../models/home_model/home_model.dart';
import '../../models/category_model/category_model.dart';

class Products extends StatelessWidget {
  Widget productsBuilder(HomeModel homeModel, CategoryModel categoryModel,
          BuildContext context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: Duration(
                seconds: 1,
              ),
              autoPlayCurve: Curves.easeIn,
              scrollDirection: Axis.horizontal,
            ),
            items: homeModel.data.banners
                .map(
                  (element) => Image.network(
                    '${element.image}',
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Container(
                        width: 0,
                        height: 0,
                      );
                    },
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleSection('Categories', context),
                SizedBox(height: 8.0),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoryModel.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 8.0,
                    ),
                    itemCount: categoryModel.data.data.length,
                  ),
                ),
                SizedBox(height: 8.0),
                titleSection('New Products', context),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
                homeModel.data.products.length,
                (index) =>
                    buildGridProduct(homeModel.data.products[index], context)),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {
        if (state is ShopSuccessChangeFavoritesDataState) {
          if (!state.changeFavoriteModel.status) {
            showToast(
              state: ToastStates.ERROR,
              text: '${state.changeFavoriteModel.message}',
            );
          }
        }
        if (state is ShopErrorFavoritesDataState) {
          showToast(
            state: ToastStates.ERROR,
            text: 'error happened',
          );
        }
      },
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition:
              shopCubit.homeModel != null && shopCubit.categoryModel != null,
          builder: (context) => productsBuilder(
              shopCubit.homeModel, shopCubit.categoryModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
