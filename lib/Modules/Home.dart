
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app1/Modules/Cubit/Cubit.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeCubit.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeStatus.dart';
import 'package:shop_app1/models/CategoriesModel.dart';
import 'package:shop_app1/models/HomeModel.dart';


class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var home=ShopAppHomeCubit.get(context);
    return
        BlocConsumer<ShopAppHomeCubit,ShopAppHomeStates>(
            builder: (context,state){
              return ConditionalBuilder(
                      condition: ShopAppHomeCubit.get(context).homeModel !=null &&ShopAppHomeCubit.get(context).categoriesModel!=null,
                      builder:(context)=> product(home.homeModel,context,home.categoriesModel),
                      fallback: (context)=>Center(

                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          color: Colors.white,
                        ),
                      )

                  );

            }, listener: (context,state){
              if(state is ShopAppFavSucssesState){
                if(!state.favoritesModel.status!){
                  Fluttertoast.showToast(
                      msg: state.favoritesModel.message!,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                }

              }


        });
      }
      Widget product(HomeModel ?home,context,CategoriesModel? categoriesModel){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(items:home?.data?.banners?.map((e) =>Image(image:NetworkImage('${e.image}') ,
            height: 70,
            width:double.infinity,
            fit: BoxFit.cover,


          )).toList(), options:CarouselOptions(

            height: 250,
            aspectRatio: 16/9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,

            scrollDirection: Axis.horizontal,
          )),
          SizedBox(
            height:15,
          ),
          Text('categories',style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30
          ),),
          SizedBox(
            height: 12,
          ),

          Container(
          height: 100,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)=>BuildCategories(categoriesModel!.data!.data[index]), separatorBuilder: (context,index)=>SizedBox(width: 15,), itemCount:categoriesModel!.data!.data.length),
          ),
          SizedBox(
            height: 30,
          ),
          Text('Products',style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30
          ),),





          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.grey[100],
            child: GridView.count(
              childAspectRatio:1/1.8,

              mainAxisSpacing:0,
              crossAxisSpacing: 7,
              shrinkWrap: true,
              physics:NeverScrollableScrollPhysics(),
              crossAxisCount: 2,children:
            List.generate(home!.data!.products!.length, (index) =>BuildProduct(home!.data!.products![index],context) )

            ,),
          )
        ],
      ),
    );
      }
      Widget BuildProduct(Productsmodel home,context){
    var cubit=ShopAppHomeCubit.get(context);
return Padding(
  padding: const EdgeInsets.all(10),
  child:   Column(



    mainAxisAlignment: MainAxisAlignment.start,

    crossAxisAlignment: CrossAxisAlignment.start,

    children:  [ Stack(

      alignment: Alignment.bottomLeft,

     children: [

       Image(image:NetworkImage('${home.image}'),

  width:200,

         height: 200,















       ),

       if(home.price!=home.old_price)

         Container(

           color: Colors.red,

           child: Text('Descount',style: TextStyle(

               color: Colors.white

           ),),)



     ],

    ),

    Text('${home.name},',style: TextStyle(



      fontSize: 15,

      fontWeight: FontWeight.bold

    ),maxLines: 2,),

      SizedBox(

          height: 2,

          ),

      Row(

        children: [

          Text('${home.price},',style: TextStyle(



              fontSize: 14,

              fontWeight: FontWeight.bold,

            color: Colors.green



          ),),

         SizedBox(

           width: 2,

         ),

          if(home.price!=home.old_price)

          Text('${home.old_price},',style: TextStyle(



              fontSize: 14,

              fontWeight: FontWeight.bold,

            color: Colors.red,

            decoration: TextDecoration.lineThrough

          ),),

          Spacer(),

          IconButton(

              padding: EdgeInsets.zero,

              onPressed: (){

                cubit.fav[home.id]!=cubit.fav[home.id];



                cubit.GetFav(home.id);

              }, icon: (cubit.fav[home.id])!?Icon(Icons.favorite):Icon(Icons.favorite_border))

        ],

      ),





    ],



  ),
);
      }
      Widget BuildCategories(Data1Model data1model){
    return  Stack(
      alignment: AlignmentDirectional.bottomCenter,

      children: [
        Image(image: NetworkImage('${data1model.image}',),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(

          width: 100,
          color: Colors.black.withOpacity(.6),
          child: Text('${data1model.name}',style: TextStyle(

            fontSize: 20,
            color: Colors.white,

          ),textAlign: TextAlign.center,maxLines: 1,),)
      ],
    );
      }

}
