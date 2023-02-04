
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Modules/Favorites.dart';
import 'package:shop_app1/Modules/Home.dart';
import 'package:shop_app1/Modules/ShopLayout.dart';
import 'package:shop_app1/Search/Cubit/SearchCubit.dart';
import 'package:shop_app1/Search/Cubit/SearchState.dart';
import 'package:shop_app1/models/Getfav.dart';

class Search extends StatelessWidget {

var searchcon=TextEditingController();
var ForKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context)=>SeachCubit(),
    child: BlocConsumer<SeachCubit,SearchState>(
      listener:(context,state){} ,
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Shoplayout()));

            }, icon: Icon(Icons.arrow_back,size: 30,color: Colors.black,)),
          ),
          body: Form(
            key: ForKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Search',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 25
                  ),),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(

                   onChanged: (index){
                     SeachCubit.get(context).Search(searchcon.text);
                    if(index==null){
                      SeachCubit.get(context).Search('');
                    }
                   },
                    controller: searchcon,
                    validator: (index){
                      if(index!.isEmpty){
                        return 'put value to search';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        suffixIcon: Icon(Icons.search,color: Colors.black,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2
                          ),

                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2
                          ),

                        )

                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                  if(state is SearchLoadingState)
                  LinearProgressIndicator(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height:
                    15,
                  ),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => build1(SeachCubit.get(context).searchModel!.data!.data![index],context),
                        separatorBuilder: (context, index) =>
                            Container(width: double.infinity,
                              height: 2,
                              color: Colors.black.withOpacity(0.1),

                            ),
                        itemCount:SeachCubit.get(context).searchModel!.data!.data!.length),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    ) ;
  }
Widget build1(product, context,{s=false}) {
  var cubit = SeachCubit.get(context);
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage("${product!.image}"),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            if (s)
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              child: Text(
                '${product.name}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                maxLines: 3,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.price}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                SizedBox(
                  width: 10,
                ),

              ],
            )
          ],
        ),
      ],
    ),
  );
}
}
