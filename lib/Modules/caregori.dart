import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeCubit.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeStatus.dart';
import 'package:shop_app1/models/CategoriesModel.dart';

class Categori extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var cate=ShopAppHomeCubit.get(context);
    return
      BlocConsumer<ShopAppHomeCubit,ShopAppHomeStates>(builder: (context,state){
        return
          Scaffold(
            backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>BuildCate(cate.categoriesModel!.data!.data[index]), separatorBuilder: (context,index)=>Container(
                 height: 2,
                 width: double.infinity,
                 color: Colors.black.withOpacity(0.2),
                ) ,itemCount: cate.categoriesModel!.data!.data.length),
              )
          )
          ;
      }, listener: (context,state){})
      
      ;
      
  }
  Widget BuildCate(Data1Model data1model){
    return Row(
      children: [
        Image(image: NetworkImage('${data1model.image}')
          ,height: 80,
          width: 80,
        ),
        SizedBox(
          width: 10,
        ),
        Text('${data1model.name}',style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800
        ),),
        Spacer(),
        IconButton(onPressed: (){}, icon:Icon(Icons.arrow_forward_ios_outlined))
      ],
    );
  }
}
