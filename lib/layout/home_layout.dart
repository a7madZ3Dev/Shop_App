import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../modules/Search/search.dart';
import '../shared/components/components.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, ShopStates state) {},
        builder: (BuildContext context, ShopStates state) {
          ShopCubit shopCubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                title: Text(
                  'Salla',
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                    ),
                    onPressed: () {
                      navigateTo(
                        context,
                        Search(),
                      );
                    },
                  ),
                ]),
            body: shopCubit.screens[shopCubit.selectedPageIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: shopCubit.changeIndex,
              currentIndex: shopCubit.selectedPageIndex,
              items: shopCubit.getBottomNavBarList(context),
            ),
          );
        });
  }
}
