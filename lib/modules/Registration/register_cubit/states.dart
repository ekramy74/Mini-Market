import 'package:mini_market/models/users_model/users_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessfulState extends RegisterState {
  final LoginModel loginModel;

  RegisterSuccessfulState(this.loginModel);
}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordIconState extends RegisterState {}
