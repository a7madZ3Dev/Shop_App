import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/components/components.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.categoryModel != null,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItem(shopCubit.categoryModel!.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: shopCubit.categoryModel!.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
