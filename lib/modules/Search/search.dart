import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../models/home_model/home_model.dart';
import '../../shared/components/components.dart';

class Search extends StatelessWidget {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, ShopStates state) {},
        builder: (BuildContext context, ShopStates state) {
          ShopCubit shopCubit = ShopCubit.get(context);
          List<Product> list = shopCubit.searchModel != null
              ? shopCubit.searchModel!.data!.data
              : [];
          return WillPopScope(
            onWillPop: () async {
              shopCubit.clearList();
              searchController.clear();
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                // automaticallyImplyLeading: false,
                // leading: IconButton(
                //     icon: Icon(Icons.arrow_back),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //       shopCubit.clearList();
                //       searchController.clear();
                //     }),
                title: Text(
                  'Search',
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defaultFormField(
                      textInputAction: TextInputAction.search,
                      controller: searchController,
                      type: TextInputType.text,
                      onChange: (String value) {
                        if (value.isEmpty)
                          BlocProvider.of<ShopCubit>(context).clearList();
                      },
                      onSubmit: (String value) {
                        if (value.isNotEmpty) shopCubit.getSearch(value);
                      },
                      validate: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'search must not be empty';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      fillColor: BlocProvider.of<AppCubit>(context).isDark
                          ? Colors.white
                          : Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  if (state is ShopGetSearchLoadingState)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: LinearProgressIndicator(),
                    ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Expanded(
                    child: searchBuilder(
                      context,
                      list,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
