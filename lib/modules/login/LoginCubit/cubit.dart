import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/models/users_model/users_model.dart';
import 'package:mini_market/modules/login/LoginCubit/state.dart';
import 'package:mini_market/network/local/endpoints.dart';
import 'package:mini_market/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  LoginModel loginModel;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userlogin({@required String email, @required String password}) {
    emit(LoginLoadingState());
    Diohelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value);
      emit(LoginSuccessfulState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData passwordicon = Icons.visibility_outlined;
  bool isPasswordvisible = true;
  void changePasswordeye() {
    isPasswordvisible = !isPasswordvisible;
    passwordicon = isPasswordvisible
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ChangePasswordIconState());
  }
}
