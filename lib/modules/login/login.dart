import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/home_layout/home.dart';
import 'package:mini_market/modules/Registration/register.dart';
import 'package:mini_market/modules/login/LoginCubit/cubit.dart';
import 'package:mini_market/modules/login/LoginCubit/state.dart';
import 'package:mini_market/network/local/cache_helper.dart';
import 'package:mini_market/sharing/components/components.dart';
import 'package:mini_market/sharing/styles/const.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessfulState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveDate(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateandFinish(context, HomeScreen());
              });

              print(state.loginModel.message);
              print(state.loginModel.data.token);
            } else {
              showtoast(
                  message: state.loginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   child: Image(
                        //     image: AssetImage('assets/images/pic.jpg'),
                        //     fit: BoxFit.cover,
                        //   ),
                        // )

                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black),
                          outsideicon: Icon(Icons.email_outlined),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          suffix: LoginCubit.get(context).passwordicon,
                          onSubmit: (value) {
                            if (formkey.currentState.validate()) {
                              LoginCubit.get(context).userlogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          isPassword: LoginCubit.get(context).isPasswordvisible,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordeye();
                          },
                          label: 'Password',
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black),
                          outsideicon: Icon(Icons.lock_outline),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formkey.currentState.validate()) {
                                  LoginCubit.get(context).userlogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              fontWeight: FontWeight.bold,
                              fontsize: 18,
                              height: 55,
                              isUpperCase: true,
                              radius: 30,
                              background: defaultcolor[300]),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegistrationScreen());
                                },
                                child: Text(
                                  'register'.toUpperCase(),
                                  style: TextStyle(color: defaultcolor),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
