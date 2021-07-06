import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/home_layout/home.dart';
import 'package:mini_market/modules/Registration/register_cubit/cubit.dart';
import 'package:mini_market/modules/Registration/register_cubit/states.dart';
import 'package:mini_market/modules/login/login.dart';
import 'package:mini_market/network/local/cache_helper.dart';
import 'package:mini_market/sharing/components/components.dart';
import 'package:mini_market/sharing/styles/const.dart';

// ignore: must_be_immutable
class RegistrationScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessfulState) {
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register to our community',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          label: 'Name',
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black),
                          outsideicon: Icon(Icons.person_outline),
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
                          controller: mobileController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                          label: 'Phone',
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black),
                          outsideicon: Icon(Icons.phone),
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
                          suffix: RegisterCubit.get(context).passwordicon,
                          onSubmit: (value) {
                            if (formkey.currentState.validate()) {
                              RegisterCubit.get(context).userlogin(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: mobileController.text,
                                  password: passwordController.text);
                              navigateandFinish(context, LoginScreen());
                            }
                          },
                          isPassword:
                              RegisterCubit.get(context).isPasswordvisible,
                          suffixPressed: () {
                            RegisterCubit.get(context).changePasswordeye();
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
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formkey.currentState.validate()) {
                                  RegisterCubit.get(context).userlogin(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: mobileController.text,
                                      password: passwordController.text);
                                  navigateandFinish(context, LoginScreen());
                                }
                              },
                              text: 'Register',
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
