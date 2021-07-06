import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';
import 'package:mini_market/sharing/components/components.dart';
import 'package:mini_market/sharing/styles/const.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var currentPassController = TextEditingController();
  var newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // ignore: unrelated_type_equality_checks
        if (HomeCubit.get(context).changePass.status == false) {
          showtoast(
              message: 'Password doesn\'t match', state: ToastState.ERROR);
        } else {
          showtoast(
              message: 'Password changed successfully',
              state: ToastState.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var model = HomeCubit.get(context).userData;

        return ConditionalBuilder(
          condition: model != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Change Password'),
              centerTitle: true,
            ),
            body: Center(
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
                              HomeCubit.get(context).changePassword(
                                  currentPass: currentPassController.text,
                                  newPass: newPassController.text);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            'update'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: defaultcolor[300],
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
