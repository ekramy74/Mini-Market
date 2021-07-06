import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/cubit/state.dart';
import 'package:mini_market/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isdark = false;

  void changeAppModeTheme({bool fromShared}) {
    if (fromShared != null) {
      isdark = fromShared;
      emit(ChangeAppModeToLightThemeState());
    } else {
      isdark = !isdark;

      CacheHelper.putData(key: 'isDark', value: isdark);
      emit(ChangeAppModeToLightThemeState());
    }
  }
}
