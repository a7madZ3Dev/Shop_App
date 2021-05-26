import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';

import '../Register/Register.dart';
import '../../shared/cubit/cubit.dart';
import '../../layout/home_layout.dart';
import '../../shared/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';

class LogIn extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopLogInSuccessState) {
        if (state.shopModel.status) {
          CacheHelper.saveData(key: kToken, token: state.shopModel.data.token)
              .then((value) {
            navigateAndReplacement(
              context,
              Home(),
            );
            showToast(
              text: 'Welcome ${state.shopModel.data.name}',
              state: ToastStates.SUCCESS,
            );
            token = shopCubit.shopModel.data.token;
            shopCubit.getHomeData();
            shopCubit.getFavoritesData();
            shopCubit.getUserData();
          });
        } else {
          showToast(
            text: state.shopModel.message,
            state: ToastStates.ERROR,
          );
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOG IN',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      'Login now to browse our hot offers',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    defaultFormField(
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Email field must not be empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                      onSaved: (String value) {
                        shopCubit.userLogInData['email'] = value;
                      },
                    ),
                    SizedBox(height: 15.0),
                    defaultFormField(
                        type: TextInputType.visiblePassword,
                        isPassword: shopCubit.isPassword,
                        suffix: shopCubit.isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixPressed: () {
                          shopCubit.changeState();
                        },
                        textInputAction: null,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Password field must not be empty';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.lock_open_outlined,
                        onSaved: (String value) {
                          shopCubit.userLogInData['password'] = value;
                        },
                        onSubmit: (value) {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            shopCubit.userLogin();
                          }
                        }),
                    SizedBox(height: 15.0),
                    ConditionalBuilder(
                      condition: state is! ShopLogInLoadingState,
                      builder: (BuildContext context) => defaultButton(
                        function: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            shopCubit.userLogin();
                          }
                        },
                        text: 'LOGIN',
                        background: Theme.of(context).primaryColor,
                      ),
                      fallback: (BuildContext context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ?',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        defaultTextButton(
                            label: 'Register',
                            onPressed: () {
                              navigateAndReplacement(
                                context,
                                Register(),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
