import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app1/Modules/Login_Screen.dart';
import 'package:shop_app1/network/Cach_Helper.dart';

void logout(context)=> CachHelper.removeData(key: 'token').then((value) {
  if(value ){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
  }
});