import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/models/users_model/users_model.dart';
import 'package:mini_market/modules/Registration/register_cubit/states.dart';
import 'package:mini_market/network/local/endpoints.dart';
import 'package:mini_market/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  LoginModel loginModel;

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userlogin(
      {@required String email,
      @required String password,
      @required String name,
      @required String phone}) {
    emit(RegisterLoadingState());
    Diohelper.postData(url: REGISTER, data: {
      'email': email,
      'name': name,
      'password': password,
      'phone': phone,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value);
      emit(RegisterSuccessfulState(loginModel));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData passwordicon = Icons.visibility_outlined;
  bool isPasswordvisible = true;
  void changePasswordeye() {
    isPasswordvisible = !isPasswordvisible;
    passwordicon = isPasswordvisible
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordIconState());
  }
}
