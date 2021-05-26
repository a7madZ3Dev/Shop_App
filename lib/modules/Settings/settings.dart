import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';

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
                text: state.shopModel.message, state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: shopCubit.shopModel != null,
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
                      height: 30.0,
                    ),
                    defaultFormField(
                      initialValue: shopCubit.shopModel.data.name,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }

                        return null;
                      },
                      onSaved: (String value) {
                        shopCubit.userUpdateData['name'] = value;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      initialValue: shopCubit.shopModel.data.email,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'email must not be empty';
                        }

                        return null;
                      },
                      onSaved: (String value) {
                        shopCubit.userUpdateData['email'] = value;
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                        initialValue: shopCubit.shopModel.data.phone,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }

                          return null;
                        },
                        onSaved: (String value) {
                          shopCubit.userUpdateData['phone'] = value;
                        },
                        textInputAction: null,
                        label: 'Phone',
                        prefix: Icons.phone,
                        onSubmit: (value) {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            shopCubit.updateUserData();
                          }
                        }),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
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
                        shopCubit.signOut(context);
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
