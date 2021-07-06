import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';
import 'package:mini_market/sharing/components/components.dart';
import 'package:mini_market/sharing/styles/const.dart';

// ignore: must_be_immutable
class PersonalInfo extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var currentPassController = TextEditingController();
  var newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessfulState) {
          showtoast(message: 'updated succssfully', state: ToastState.SUCCESS);
        } else if (state is UpdateProfileErrorState) {
          showtoast(
              message: 'something went wrong try again',
              state: ToastState.ERROR);
        }

        // ignore: unrelated_type_equality_checks
        if (HomeCubit.get(context).changePass.status == false) {
          showtoast(
              message: 'Password doesn\'t match', state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        var model = HomeCubit.get(context).userData;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: model != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Personal Info'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (state is UpdateProfileLoadingState)
                        LinearProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'name must not be empty';
                              }

                              return null;
                            },
                            label: 'Name',
                            outsideicon: Icon(Icons.person_outline_outlined),
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.black),
                            outlinedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }

                            return null;
                          },
                          label: 'email',
                          outsideicon: Icon(Icons.email_outlined),
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Phone must not be empty';
                              }

                              return null;
                            },
                            label: 'Phone',
                            outsideicon: Icon(Icons.phone),
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.black),
                            outlinedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultFormField(
                          controller: currentPassController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password must not be empty';
                            }

                            return null;
                          },
                          label: 'Current password',
                          outsideicon: Icon(Icons.lock_outline_rounded),
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultFormField(
                          controller: newPassController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password must not be empty';
                            }

                            return null;
                          },
                          label: 'New password',
                          outsideicon: Icon(Icons.lock_open_rounded),
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              HomeCubit.get(context).updateUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);

                              HomeCubit.get(context).changePassword(
                                  currentPass: currentPassController.text,
                                  newPass: newPassController.text);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            'UPDATE'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: defaultcolor,
                          height: 50,
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
    );
  }
}
