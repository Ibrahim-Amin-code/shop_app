import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/models/shop_app/search_model.dart';
import 'package:udemy_flutter111/modules/shop_app/search/cubit/states.dart';
import 'package:udemy_flutter111/shared/components/constants.dart';
import 'package:udemy_flutter111/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter111/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(InitialState());

 static SearchCubit get(context) => BlocProvider.of(context);

 SearchModel model;

 void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}