import 'package:mini_market/models/cart_model/cart_model.dart';
import 'package:mini_market/models/change_password_model/change_pass.dart';
import 'package:mini_market/models/favorites_model/favorites_model.dart';
import 'package:mini_market/models/users_model/users_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeBottomNavState extends HomeStates {}

class HomeDataLoadingState extends HomeStates {}

class HomeDataSuccessState extends HomeStates {}

class HomeDataErrorState extends HomeStates {}

class HomeGetCategoryLoadingState extends HomeStates {}

class HomeGetCategorySuccessState extends HomeStates {}

class HomeGetCategoryErrorState extends HomeStates {}

class HomeFavoritesState extends HomeStates {}

class HomeGetFavoritesSuccessState extends HomeStates {
  final ChangeFavoritesModel model;

  HomeGetFavoritesSuccessState(this.model);
}

class HomeFavoritesLoadingState extends HomeStates {}

class HomeFavoritesSuccessState extends HomeStates {}

class HomefavoritesErrorState extends HomeStates {}

class HomeGetFavoritesErrorState extends HomeStates {}

class HomeGetUserLoadingState extends HomeStates {}

class HomeGetUserSuccessState extends HomeStates {}

class HomeGetUserErrorState extends HomeStates {}

class ChangeExpanionState extends HomeStates {}

class AppInitialState extends HomeStates {}

class ChangeAppModeState extends HomeStates {}

class HomeCartState extends HomeStates {}

class HomeGetCartSuccessState extends HomeStates {
  final ChangecartModel model;

  HomeGetCartSuccessState(this.model);
}

class HomecartLoadingState extends HomeStates {}

class HomecartSuccessState extends HomeStates {}

class HomecartErrorState extends HomeStates {}

class HomeGetcartErrorState extends HomeStates {}

class UpdateProfileLoadingState extends HomeStates {}

class UpdateProfileSuccessfulState extends HomeStates {
  final LoginModel loginModel;

  UpdateProfileSuccessfulState(this.loginModel);
}

class UpdateProfileErrorState extends HomeStates {
  final String error;

  UpdateProfileErrorState(this.error);
}

class ChangePassSuccessfully extends HomeStates {}

class ChangePassError extends HomeStates {
  final ChangePass changePass;

  ChangePassError(this.changePass);
}
