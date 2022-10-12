import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/components/components.dart';

class Settings extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {
        if (state is ShopSuccessUpdateProfileState) {
          if (state.shopModel.status) {
            showToast(
                text: state.shopModel.message!, state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateProfileState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      initialValue: shopCubit.userModel!.data!.name,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        shopCubit.userUpdateData['name'] = value!;
                      },
                      textInputAction: TextInputAction.next,
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      initialValue: shopCubit.userModel!.data!.email,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        shopCubit.userUpdateData['email'] = value!;
                      },
                      textInputAction: TextInputAction.next,
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                        initialValue: shopCubit.userModel!.data!.phone,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          shopCubit.userUpdateData['phone'] = value!;
                        },
                        textInputAction: TextInputAction.done,
                        label: 'Phone',
                        prefix: Icons.phone,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            shopCubit.updateUserData();
                          }
                        }),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          shopCubit.updateUserData();
                        }
                      },
                      text: 'update',
                      background: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                      function: () {
                        shopCubit.userSignOut(context);
                      },
                      text: 'Log out',
                      background: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
