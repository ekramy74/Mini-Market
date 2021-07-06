import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';
import 'package:mini_market/modules/settings/change_pass/changepass_screen.dart';
import 'package:mini_market/modules/settings/personal_info/personal_info.dart';
import 'package:mini_market/sharing/components/components.dart';
import 'package:mini_market/sharing/styles/const.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userData;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome ${model.data.name.toUpperCase()} ,',
                  style: TextStyle(
                    color: AppCubit.get(context).isdark
                        ? Colors.black
                        : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    Container(
                      child: TextButton(
                        onPressed: () {
                          navigateTo(context, PersonalInfo());
                        },
                        child: Text(
                          'Personal info'.toUpperCase(),
                          style: TextStyle(
                              color: AppCubit.get(context).isdark
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myDivider(padding: 20),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        'top dealers'.toUpperCase(),
                        style: TextStyle(
                            color: AppCubit.get(context).isdark
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    myDivider(padding: 20),
                    SizedBox(height: 20),
                    // Container(
                    //   child: Text(
                    //     'theme'.toUpperCase(),
                    //     style:
                    //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // ignore: deprecated_member_use
                    FlatButton(
                        onPressed: () {
                          AppCubit.get(context).changeAppModeTheme();
                        },
                        child: Text(
                          AppCubit.get(context).isdark
                              ? 'Dark Theme'.toUpperCase()
                              : 'Light Theme'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppCubit.get(context).isdark
                                  ? Colors.black
                                  : Colors.white),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    myDivider(padding: 20),
                    SizedBox(height: 30),
                    Container(
                      child: Text(
                        'orders'.toUpperCase(),
                        style: TextStyle(
                            color: AppCubit.get(context).isdark
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    myDivider(padding: 20),
                    SizedBox(height: 20),
                    Container(
                      child: TextButton(
                        child: Text(
                          'Change password'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppCubit.get(context).isdark
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        onPressed: () {
                          navigateTo(context, ChangePasswordScreen());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myDivider(padding: 20),
                    SizedBox(height: 20),
                    Container(
                      child: TextButton(
                        child: Text(
                          'Signout'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: defaultcolor[300]),
                        ),
                        onPressed: () {
                          signout(context);
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
