import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeCubit.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeStatus.dart';
import 'package:shop_app1/models/Getfav.dart';

class Faveroites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopAppHomeCubit.get(context);
    return BlocConsumer<ShopAppHomeCubit, ShopAppHomeStates>(
        builder: (context, state) {
          return Scaffold(

              body: ConditionalBuilder(
                  condition: state != ShopAppgetfavLoadingState(),
                  builder: (context)=>ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => build1(cubit.getFavModel!.data!.data![index],context),
                      separatorBuilder: (context, index) =>
                          Container(width: double.infinity,
                            height: 2,
                            color: Colors.black.withOpacity(0.1),

                          ),
                      itemCount: cubit.getFavModel!.data!.data!.length),
                  fallback:(context)=>Center(
                    child:CircularProgressIndicator(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                    ) ,
                  )));
        },
        listener: (context, state) {});
  }

  Widget build1(FavData? favData, context) {
    var cubit = ShopAppHomeCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage("${favData!.product!.image}"),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              if (favData!.product!.price != favData.product!.oldPrice)
                Container(
                  color: Colors.red,
                  child: Text(
                    'Descount',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                child: Text(
                  '${favData.product!.name}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${favData.product!.price}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  if (true)
                    Text(
                      '${favData.product!.oldPrice}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough),
                    ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        cubit.fav[favData.product!.id] !=
                            cubit.fav[favData.product!.id];

                        cubit.GetFav(favData.product!.id);
                      },
                      icon: (cubit.fav[favData.product!.id])!
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
