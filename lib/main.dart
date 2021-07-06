import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/cubit/cubit.dart';
import 'package:mini_market/layout/cubit/state.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/home.dart';
import 'package:mini_market/modules/login/login.dart';
import 'package:mini_market/modules/onboard/onboard.dart';
import 'package:mini_market/network/local/cache_helper.dart';
import 'package:mini_market/network/remote/dio_helper.dart';
import 'package:mini_market/sharing/bloc_observer.dart';
import 'package:mini_market/sharing/styles/const.dart';
import 'package:mini_market/sharing/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;
  token = CacheHelper.getData(key: 'token');
  print(token);

  bool onBoarding = CacheHelper.getData(key: 'OnBoarding');

  if (onBoarding != null) {
    if (token != null)
      widget = HomeScreen();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(isDark: isDark, startwidget: widget));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startwidget;

  MyApp({this.isDark, this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AppCubit()..changeAppModeTheme(fromShared: isDark),
          ),
          BlocProvider(
              create: (context) => HomeCubit()
                ..getHomedata()
                ..getCategorydata()
                ..getfavoritesdata()
                ..getuserdata()
                ..getcartdata()),
        ],
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darktheme,
                themeMode: AppCubit.get(context).isdark
                    ? ThemeMode.light
                    : ThemeMode.dark,
                home: startwidget);
          },
        ));
  }
}
