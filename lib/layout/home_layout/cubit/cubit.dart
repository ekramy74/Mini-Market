import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';
import 'package:mini_market/models/Get_Favorites/get_favorites.dart';
import 'package:mini_market/models/Home_model/home_model.dart';
import 'package:mini_market/models/cart_model/cart_model.dart';
import 'package:mini_market/models/category_model/category_model.dart';
import 'package:mini_market/models/change_password_model/change_pass.dart';
import 'package:mini_market/models/favorites_model/favorites_model.dart';
import 'package:mini_market/models/get_cart/get_cart.dart';
import 'package:mini_market/models/users_model/users_model.dart';
import 'package:mini_market/modules/cart/cart.dart';
import 'package:mini_market/modules/categories/categories.dart';
import 'package:mini_market/modules/favorites/favorites.dart';
import 'package:mini_market/modules/products/products.dart';
import 'package:mini_market/modules/settings/settings.dart';
import 'package:mini_market/network/local/endpoints.dart';
import 'package:mini_market/network/remote/dio_helper.dart';
import 'package:mini_market/sharing/styles/const.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
    SettingsScreen()
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};

  void getHomedata() {
    emit(HomeDataLoadingState());

    Diohelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.infavorites});
      });
      homeModel.data.products.forEach((element) {
        cart.addAll({element.id: element.incart});
      });
      print(cart.toString());
      print(favorites.toString());
      emit(HomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeDataErrorState());
    });
  }

  CategoryModel categoryModel;
  void getCategorydata() {
    emit(HomeDataLoadingState());

    Diohelper.getData(
      url: GETCATEOGRIES,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(HomeGetCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetCategoryErrorState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productID) {
    favorites[productID] = !favorites[productID];
    emit(HomeFavoritesState());
    Diohelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productID,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel.status) {
        favorites[productID] = !favorites[productID];
      } else {
        getfavoritesdata();
      }

      emit(HomeGetFavoritesSuccessState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productID] = !favorites[productID];

      emit(HomeGetFavoritesErrorState());
    });
  }

  GetFavorites getFavorites;
  void getfavoritesdata() {
    emit(HomeFavoritesLoadingState());

    Diohelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      getFavorites = GetFavorites.fromJson(value.data);

      emit(HomeFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomefavoritesErrorState());
    });
  }

  ChangecartModel changecartModel;
  void changecart(int productID) {
    cart[productID] = !cart[productID];
    emit(HomeCartState());
    Diohelper.postData(
      url: CART,
      data: {
        'product_id': productID,
      },
      token: token,
    ).then((value) {
      changecartModel = ChangecartModel.fromJson(value.data);
      print(value.data);

      if (!changecartModel.status) {
        cart[productID] = !cart[productID];
      } else {
        getcartdata();
      }

      emit(HomeGetCartSuccessState(changecartModel));
    }).catchError((error) {
      cart[productID] = !cart[productID];

      emit(HomeGetcartErrorState());
    });
  }

  GetCart getcart;
  void getcartdata() {
    emit(HomecartLoadingState());

    Diohelper.getData(
      url: CART,
      token: token,
    ).then((value) {
      getcart = GetCart.fromJson(value.data);

      emit(HomecartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomecartErrorState());
    });
  }

  LoginModel userData;
  void getuserdata() {
    emit(HomeGetUserLoadingState());

    Diohelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData.data.name);

      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetUserErrorState());
    });
  }

  bool isExpanded = false;
  void changeExpanionMode() {
    isExpanded = !isExpanded;
    emit(ChangeExpanionState());
  }

  void updateUser(
      {@required String email,
      // String password,
      String name,
      String phone}) {
    emit(UpdateProfileLoadingState());
    Diohelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'email': email,
      // 'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(value);
      emit(UpdateProfileSuccessfulState(userData));
    }).catchError((error) {
      emit(UpdateProfileErrorState(error.toString()));
    });
  }

  ChangePass changePass;

  void changePassword({String currentPass, String newPass}) {
    Diohelper.postData(
            url: CHANGEPASS,
            data: {
              'current_password': currentPass,
              'new_password': newPass,
            },
            token: token)
        .then((value) {
      changePass = ChangePass.fromJson(value.data);
      emit(ChangePassSuccessfully());
    }).catchError((error) {
      emit(ChangePassError(changePass));
    });
  }
}
