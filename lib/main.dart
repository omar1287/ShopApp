import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Componnent/const.dart';
import 'package:shop_app1/Modules/Cubit/Cubit.dart';
import 'package:shop_app1/Modules/Cubit/State.dart';
import 'package:shop_app1/Modules/Home.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeCubit.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeStatus.dart';
import 'package:shop_app1/Modules/ShopLayout.dart';
import 'package:shop_app1/network/Cach_Helper.dart';
import 'package:shop_app1/network/DioHelper.dart';
import 'package:shop_app1/Modules/Login_Screen.dart';
import 'package:shop_app1/Modules/OnBoarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await  CachHelper.init();
  DioHelper.init();
  Widget widget;
 bool ?onboarding= CachHelper.getData(key: "onboarding");
 Token!=CachHelper.getData(key: 'token');

if(onboarding!=null){
  if(Token!=null){ widget=Shoplayout();}else{
    widget=LoginScreen();
  }

}else{
  widget=OnBoarding();
}

  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
 final Widget widget;

MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[
      BlocProvider(create: (context)=>ShopAppCubit()),
      BlocProvider(create:(context)=>ShopAppHomeCubit()..GetDataHome()..GetDataCate()..GetData1Cate()..GetProfCate())
    ] ,
    child: BlocConsumer<ShopAppHomeCubit,ShopAppHomeStates>(
      listener:(context,states){} ,
      builder: (context,states){
        return MaterialApp(
          home:widget,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              backgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white)),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:25,
                      color: Colors.black
                  ))),
        );
      },
    )
    );
  }
}
