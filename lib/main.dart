import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constants.dart';

import './shared/cubit/cubit.dart';
import './layout/home_layout.dart';
import './modules/login/logIn.dart';
import './shared/cubit/states.dart';
import './shared/styles/themes.dart';
import './shared/bloc_observer.dart';
import './modules/on_boarding/on_boarding.dart';
import './shared/network/remote/dio_helper.dart';
import './shared/network/local/cache_helper.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  bool onBoarding = await CacheHelper.getData(key: kOnBoarding);
  token = await CacheHelper.getData(key: kToken);

  DioHelper.init();
  runApp(MyApp(token: token, onBoarding: onBoarding));
}

class MyApp extends StatelessWidget {
  final String token;
  final bool onBoarding;
  MyApp({this.onBoarding, this.token});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopCubit>(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData(),
        ),
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit()..getAppMode(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit appCubit = AppCubit.get(context);
          return MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: appCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: onBoarding
                ? (token != null && token.isNotEmpty ? Home() : LogIn())
                : OnBoarding(),
          );
        },
      ),
    );
  }
}
