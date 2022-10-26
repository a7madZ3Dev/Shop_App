import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/states.dart';
import '../network/end_pointes.dart';
import '../components/components.dart';
import '../../modules/login/logIn.dart';
import '../network/remote/dio_helper.dart';
import '../network/local/cache_helper.dart';
import '../../modules/Settings/settings.dart';
import '../../modules/Products/products.dart';
import '../../modules/Favorite/favorite.dart';
import '../../shared/components/constants.dart';
import '../../models/home_model/home_model.dart';
import '../../modules/Categories/categories.dart';
import '../../models/search_model/search_model.dart';
import '../../models/favorite_model/favorite_model.dart';
import '../../models/category_model/category_model.dart';
import '../../models/login_register_model/login_register_model.dart';
import '../../models/change_favorite_model/change_favorites_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  // get object from cubit class
  static ShopCubit get(context) => BlocProvider.of<ShopCubit>(context);

  Map<String, String> userLogInData = {
    'email': '',
    'password': '',
  };
  Map<String, String> userRegisterData = {
    'name': '',
    'email': '',
    'password': '',
    'phone': '',
  };
  Map<String, String> userUpdateData = {
    'name': '',
    'email': '',
    'phone': '',
  };

  bool isPassword = true;
  int selectedPageIndex = 0;
  Map<int, bool> favorites = {};
  List favoriteProducts = [];

  // models
  UserModel? userModel;
  HomeModel? homeModel;
  SearchModel? searchModel;
  CategoryModel? categoryModel;
  FavoriteModel? favoriteModel;
  ChangeFavoriteModel? changeFavoriteModel;

  // screens
  final List<Widget> screens = [
    Products(),
    Categories(),
    Favorite(),
    Settings(),
  ];

  // tabs for nav bar
  List<BottomNavigationBarItem> getBottomNavBarList(BuildContext context) {
    List<BottomNavigationBarItem> bottomItem = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.category_rounded),
        label: 'Categories',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ];
    return bottomItem;
  }

  // change number for pages
  void changeIndex(int index) {
    selectedPageIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  // check favorite state
  bool checkState(int key) {
    var result = favorites.containsKey(key);
    if (!result) {
      return false;
    } else {
      return favorites[key]!;
    }
  }

  // change state of password field
  void changeState() {
    isPassword = !isPassword;
    emit(ShopChangePasswordState());
  }

  // for login the user
  void userLogin() {
    emit(ShopLogInLoadingState());
    DioHelper.postDataToApi(
      url: '$kLogin',
      data: userLogInData,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopLogInSuccessState(userModel!));
    }).catchError((error) {
      emit(ShopLogInErrorState(error.toString()));
      print(error.toString());
    });
  }

  // for register a user
  void userRegister() {
    emit(ShopRegisterLoadingState());
    DioHelper.postDataToApi(
      url: '$kRegister',
      data: userRegisterData,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(userModel!));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  // signOut the user
  void userSignOut(context) {
    CacheHelper.deleteData().then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LogIn(),
        );
        selectedPageIndex = 0;
      }
    });
  }

  // get home data
  void getHomeData() {
    CacheHelper.getData(key: kToken).then((token) {
      if (token.isNotEmpty && homeModel == null) {
        emit(ShopLoadingHomeDataState());
        DioHelper.getDataFromApi(
          url: '$kHome',
          token: token,
        ).then((value) {
          homeModel = HomeModel.fromJson(value.data);
          homeModel?.data?.products.forEach((element) {
            favorites.addAll({element.id: element.inFavorites!});
          });
          emit(ShopSuccessHomeDataState(homeModel!));
        }).catchError((error) {
          emit(ShopErrorHomeDataState(error.toString()));
          print(error.toString());
        });
      } else {
        print(
            'will not get any home data because does not have token or the model already exists');
      }
    });
  }

  // get Categories data
  void getCategoriesData() {
    CacheHelper.getData(key: kToken).then((token) {
      if (token.isNotEmpty && categoryModel == null) {
        emit(ShopLoadingCategoriesDataState());
        DioHelper.getDataFromApi(
          url: '$kCategories',
        ).then((value) {
          categoryModel = CategoryModel.fromJson(value.data);
          emit(ShopSuccessCategoriesDataState());
        }).catchError((error) {
          emit(ShopErrorCategoriesDataState(error.toString()));
          print(error.toString());
        });
      } else {
        print(
            'will not get any home data because does not have token or the model already exists');
      }
    });
  }

  // get Favorites data
  void getFavoritesData() {
    CacheHelper.getData(key: kToken).then((token) {
      if (token.isNotEmpty) {
        emit(ShopLoadingGetFavoritesDataState());
        DioHelper.getDataFromApi(
          url: '$kFavorites',
          token: token,
        ).then((value) {
          favoriteModel = FavoriteModel.fromJson(value.data);
          emit(ShopSuccessGetFavoritesDataState());
        }).catchError((error) {
          emit(ShopErrorGetFavoritesDataState(error.toString()));
          print(error.toString());
        });
      } else {
        print(
            'will not get any favorites data because does not have token or the model already exists');
      }
    });
  }

  // change favorite state
  void changeFavorites(int key) {
    CacheHelper.getData(key: kToken).then((token) {
      bool oldValue = favorites[key]!;
      favorites[key] = !favorites[key]!;
      emit(ShopLoadingChangeFavoritesDataState());
      DioHelper.postDataToApi(
        url: '$kFavorites',
        data: {
          'product_id': key,
        },
        token: token,
      ).then(
        (value) {
          changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
          if (!changeFavoriteModel!.status) {
            favorites[key] = oldValue;
            emit(ShopErrorFavoritesDataState());
          } else {
            getFavoritesData();
            emit(ShopSuccessChangeFavoritesDataState());
          }
        },
      ).catchError((error) {
        favorites[key] = oldValue;
        emit(ShopErrorFavoritesDataState());
        print(error.message);
      });
    });
  }

  // get user profile
  void getUserData() {
    CacheHelper.getData(key: kToken).then((token) {
      if (token.isNotEmpty && userModel == null) {
        emit(ShopLoadingGetProfileState());
        DioHelper.getDataFromApi(
          url: '$kProfile',
          token: token,
        ).then((value) {
          userModel = UserModel.fromJson(value.data);
          emit(ShopSuccessGetProfileState(shopModel: userModel!));
        }).catchError((error) {
          emit(ShopErrorGetProfileState(error.toString()));
          print(error.toString());
        });
      } else {
        print(
            'will not get any profile data because does not have token or the model already exists');
      }
    });
  }

  // update user data
  void updateUserData() {
    CacheHelper.getData(key: kToken).then((token) {
      emit(ShopLoadingUpdateProfileState());
      DioHelper.putDataToApi(
        url: '$kUpdate',
        data: userUpdateData,
        token: token,
      ).then((value) {
        userModel = UserModel.fromJson(value.data);
        emit(ShopSuccessUpdateProfileState(userModel!));
      }).catchError((error) {
        emit(ShopErrorUpdateProfileState(error.toString()));
        print(error.toString());
      });
    });
  }

  // search data
  void getSearch(String value) {
    CacheHelper.getData(key: kToken).then((token) {
      emit(ShopGetSearchLoadingState());
      DioHelper.postDataToApi(
        url: '$kSearch',
        data: {
          'text': '$value',
        },
        token: token,
      ).then((value) {
        searchModel = SearchModel.fromJson(value.data);
        emit(ShopGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ShopGetSearchErrorState(error.toString()));
      });
    });
  }

  // when ending with search
  void clearList() {
    searchModel = null;
    emit(ShopGetSearchSuccessState());
  }
}

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  // get object from cubit class
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  bool isDark = false;

  //change theme mode
  void changeAppMode() {
    isDark = !isDark;
    CacheHelper.saveData(
      key: kIsDark,
      value: isDark,
    ).then((value) => emit(AppChangeModeState()));
  }

  //get theme mode
  void getAppMode() {
    CacheHelper.getData(key: kIsDark).then((value) {
      isDark = value;
      emit(AppChangeModeState());
    });
  }
}
