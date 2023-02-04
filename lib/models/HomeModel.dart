
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class HomeModel{
  bool ?status;
DataModel ? data;
  HomeModel.fromJson(Map<String,dynamic> json){
    status= json['status'];
    data=DataModel.fromJson(json['data']);
  }


}
class DataModel{

List<Bannersmodel> ?banners=[];
List<Productsmodel> ?products=[];
DataModel.fromJson(Map<String,dynamic> json){
  json['banners'].forEach((v) {
    banners?.add(new Bannersmodel.fromJson(v));
  });
  json['products'].forEach((v) {
    products?.add(new Productsmodel.fromJson(v));
  });
}


}
class Bannersmodel{
  int ?id;
  String ?image;

  Bannersmodel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];


  }

}
class Productsmodel{
  int ? id;
  String? image;
  dynamic price;
  dynamic old_price;
  String ? name;
 bool ?in_favorite;
  bool? in_cart;

  Productsmodel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image=json['image'];
   price=json['price'];
    old_price=json['old_price'];
    name=json['name'];
    in_favorite=json['in_favorites'];
    in_cart=json['in_cart'];

  }


}