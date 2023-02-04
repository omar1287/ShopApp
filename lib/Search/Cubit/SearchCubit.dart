import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Componnent/const.dart';
import 'package:shop_app1/Search/Cubit/SearchState.dart';
import 'package:shop_app1/models/SearchModel.dart';

import 'package:shop_app1/network/DioHelper.dart';

class SeachCubit extends Cubit<SearchState>{
  SeachCubit():super(SearchIntialState());
   static SeachCubit get(context)=>BlocProvider.of(context);
  SearchModel ?searchModel;
   void Search( String text){
     emit(SearchLoadingState());
     DioHelper.postData(url: 'products/search',data:{
       'text':text,

     } ,token: Token).then((value) {
       searchModel=SearchModel.fromJson(value.data);
       print(value.data.toString());
       emit(SearchSuccessState());


     }).catchError((e){
       print(e.toString());
       emit(SearchErrorState());
     });

     
     
   }

}