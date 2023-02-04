import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Modules/Cubit/Cubit.dart';
import 'package:shop_app1/Modules/Cubit/State.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeCubit.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeStatus.dart';
import 'package:shop_app1/Search/Search_Screen.dart';

class Shoplayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppHomeCubit, ShopAppHomeStates>(
          builder:(context,state){
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                onTap:(index){
                  ShopAppHomeCubit.get(context).changeindex(index);
                },
                currentIndex:ShopAppHomeCubit.get(context).CurrentIndex ,
selectedItemColor: Colors.grey,
                unselectedItemColor: Colors.black,

                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home, ),label: 'Home',),
                  BottomNavigationBarItem(icon: Icon(Icons.app_registration,),label: 'Categories'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: 'Favorites'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Settings'),
                ],
              ),
              backgroundColor: Colors.white,
              appBar: AppBar(
                title:  Text('Salla',style: Theme.of(context).textTheme.bodyText1,),
                actions: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
                  }, icon: Icon(Icons.search,color: Colors.black,size: 30,),)
                ],
              ),
              body: ShopAppHomeCubit.get(context).Screens[ShopAppHomeCubit.get(context).CurrentIndex],

            );
          }, listener:(context,states){});

  }
}
