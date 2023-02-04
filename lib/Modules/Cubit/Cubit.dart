 import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Componnent/const.dart';
import 'package:shop_app1/Modules/Cubit/State.dart';
import 'package:shop_app1/Modules/Favorites.dart';
import 'package:shop_app1/Modules/Home.dart';
import 'package:shop_app1/Modules/Settings.dart';
import 'package:shop_app1/Modules/caregori.dart';
import 'package:shop_app1/models/HomeModel.dart';
import 'package:shop_app1/network/DioHelper.dart';
import 'package:shop_app1/models/ShopLoginModel.dart';

class ShopAppCubit extends Cubit<ShopAppStates>{

  ShopAppCubit():super(ShopAppIntialState());

  static ShopAppCubit get(context)=>BlocProvider.of(context);

  UserModel ?shopLoginModel;
  void putEandP({ required String Email,required String Pass}){
    emit(ShopAppLoadingState());
  DioHelper.postData(url: 'login', data:{
      'email':Email,
      'password':Pass

    }).then((value){

   shopLoginModel=  UserModel.fromJson(value!.data);
   print(shopLoginModel?.message);
   print(shopLoginModel?.status);
   print(shopLoginModel!.data!.token);
      emit(ShopAppSucssesState(shopLoginModel!));
  }).catchError((e){
    emit(ShopAppErrorState(e.toString(),shopLoginModel!));
    print( e.toString());
  });


  }



}