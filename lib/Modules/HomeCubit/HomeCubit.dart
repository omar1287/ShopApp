import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Componnent/const.dart';
import 'package:shop_app1/Modules/Favorites.dart';
import 'package:shop_app1/Modules/Home.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeStatus.dart';
import 'package:shop_app1/Modules/Settings.dart';
import 'package:shop_app1/Modules/caregori.dart';
import 'package:shop_app1/models/CategoriesModel.dart';
import 'package:shop_app1/models/FavoritesModel.dart';
import 'package:shop_app1/models/Getfav.dart';
import 'package:shop_app1/models/HomeModel.dart';
import 'package:shop_app1/models/ShopLoginModel.dart';
import 'package:shop_app1/network/DioHelper.dart';

class ShopAppHomeCubit extends Cubit<ShopAppHomeStates> {

  ShopAppHomeCubit() :super(ShopAppHomeIntialState());

  static ShopAppHomeCubit get(context) => BlocProvider.of(context);


  List<Widget>Screens = [
    Home(),
    Categori(),
    Faveroites(),
    Settings()

  ];
  int CurrentIndex = 0;

  void changeindex(index) {
    CurrentIndex = index;
    emit(ShopAppHomeChangeScreens());
  }



  HomeModel ?homeModel;
  Map<int?,bool?>fav={};
  void GetDataHome() {
    emit(ShopAppHomeLoadingState());

   DioHelper.getData(url: 'home',token: Token).then((value) {
     homeModel=HomeModel.fromJson(value!.data);
     homeModel!.data!.products!.forEach((element) {
       fav.addAll({
         element.id ! : element.in_favorite,
       });
     });
  print(Token);
     emit(ShopAppHomeSucssesState());
   }).catchError((e){
     print(e.toString());


     emit(ShopAppHomeErrorState());
   });
  }
  CategoriesModel ?categoriesModel;
  void GetDataCate() {

    DioHelper.getData(url: Categories).then((value) {
      categoriesModel=CategoriesModel.fromJson(value!.data);

      emit(ShopAppCateSucssesState());
    }).catchError((e){
      print(e.toString());
      emit(ShopAppCateErrorState());
    });
  }
  FavoritesModel ?favoritesModel;
  void GetFav(int? ProductId){
    fav[ProductId]= !fav[ProductId]!;
    emit(ShopAppFavChange());
    DioHelper.postData(url: 'favorites',data: {
      'product_id':ProductId,
    },token: Token).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopAppFavSucssesState(favoritesModel: favoritesModel!));
      if(!favoritesModel!.status!){
        fav[ProductId]= !fav[ProductId]!;

      }else{
        GetData1Cate();
      }
print(value.data);
    }).catchError((e){
      fav[ProductId]= !fav[ProductId]!;
      emit(ShopAppFavErrorState());
    });

  }
GetFavModel ?getFavModel;
  void GetData1Cate() {
emit(ShopAppgetfavLoadingState());
    DioHelper.getData(url: 'favorites',
    token: Token).then((value) {
      getFavModel=GetFavModel.fromJson(value!.data);

      emit(ShopAppgetfavSucssesState());
    }).catchError((e){
      print(e.toString());
      emit(ShopAppgetfavErrorState());
    });
  }

  UserModel ?userModel;
  void GetProfCate() {
    emit(ShopAppShowproLoadingState());
    DioHelper.getData(url: 'profile',
        token: Token).then((value) {
      userModel=UserModel.fromJson(value!.data);

      emit(ShopAppShowproSucssesState());
    }).catchError((e){
      print(e.toString());
      emit(ShopAppShowproErrorState());
    });
  }
  void GetUpDate({required String name,required String Email,required String Phone}) {
    emit(ShopAppUpDateLoadingState());
    DioHelper.putData(url: 'update-profile',
        token: Token,data: {
      'name':name,
          'email':Email,
          'phone':Phone
        }).then((value) {
      userModel=UserModel.fromJson(value!.data);

      emit(ShopAppUpDateSucssesState());
    }).catchError((e){
      print(e.toString());
      emit(ShopAppUpDateErrorState());
    });
  }
}
