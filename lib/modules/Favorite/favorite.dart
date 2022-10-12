import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/components/components.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {
        if (state is ShopErrorFavoritesDataState) {
          showToast(
            state: ToastStates.ERROR,
            text: 'can\'t favorite it',
          );
        }
      },
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.favoriteModel != null && state is! ShopLoadingGetFavoritesDataState,
          builder: (context) => shopCubit.favoriteModel!.data!.data.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (BuildContext context, int index) => 
                      favoriteItem(
                    context,
                    shopCubit.favoriteModel!.data!.data[index],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      myDivider(),
                  itemCount: shopCubit.favoriteModel!.data!.data.length,
                )
              : Center(
                  child: Container(
                    child: Text(
                      'No favorite items yet',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
