import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/models/search_model/search_model.dart';
import 'package:mini_market/modules/search/cubit/search_states.dart';
import 'package:mini_market/network/local/endpoints.dart';
import 'package:mini_market/network/remote/dio_helper.dart';
import 'package:mini_market/sharing/styles/const.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;
  void getSearch({String text}) {
    emit(SearchLoadingState());
    Diohelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
