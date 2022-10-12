import '../../models/change_favorite_model/change_favorites_model.dart';
import '../../models/home_model/home_model.dart';
import '../../models/login_register_model/login_register_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

// Password Field
class ShopChangePasswordState extends ShopStates {}

// bottom navBar
class ShopChangeBottomNavBarState extends ShopStates {}

// Log In
class ShopLogInLoadingState extends ShopStates {}

class ShopLogInSuccessState extends ShopStates {
  final UserModel shopModel;

  ShopLogInSuccessState(this.shopModel);
}

class ShopLogInErrorState extends ShopStates {
  final String error;

  ShopLogInErrorState(this.error);
}

// Register
class ShopRegisterLoadingState extends ShopStates {}

class ShopRegisterSuccessState extends ShopStates {
  final UserModel shopModel;

  ShopRegisterSuccessState(this.shopModel);
}

class ShopRegisterErrorState extends ShopStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

// Get Profile
class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {
  final UserModel? shopModel;
  ShopSuccessGetProfileState({
    this.shopModel,
  });
}

class ShopErrorGetProfileState extends ShopStates {
  final String error;
  ShopErrorGetProfileState(this.error);
}

// Update Profile
class ShopLoadingUpdateProfileState extends ShopStates {}

class ShopSuccessUpdateProfileState extends ShopStates {
  final UserModel shopModel;

  ShopSuccessUpdateProfileState(this.shopModel);
}

class ShopErrorUpdateProfileState extends ShopStates {
  final String error;
  ShopErrorUpdateProfileState(this.error);
}

// Products
class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {
  final HomeModel homeModel;
  ShopSuccessHomeDataState(this.homeModel);
}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

// Categories
class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {
  final String error;

  ShopErrorCategoriesDataState(this.error);
}

// Change Favorites
class ShopLoadingChangeFavoritesDataState extends ShopStates {}

class ShopSuccessChangeFavoritesDataState extends ShopStates {
  final ChangeFavoriteModel? changeFavoriteModel;
  ShopSuccessChangeFavoritesDataState({
    this.changeFavoriteModel,
  });
}

class ShopErrorFavoritesDataState extends ShopStates {}

// Favorites
class ShopLoadingGetFavoritesDataState extends ShopStates {}

class ShopSuccessGetFavoritesDataState extends ShopStates {}

class ShopErrorGetFavoritesDataState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesDataState(this.error);
}

// Search
class ShopGetSearchLoadingState extends ShopStates {}

class ShopGetSearchSuccessState extends ShopStates {}

class ShopGetSearchErrorState extends ShopStates {
  final String error;

  ShopGetSearchErrorState(this.error);
}

// for theme mode
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeModeState extends AppStates {}
