import 'package:mini_market/models/users_model/users_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessfulState extends LoginState {
  final LoginModel loginModel;

  LoginSuccessfulState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordIconState extends LoginState {}
