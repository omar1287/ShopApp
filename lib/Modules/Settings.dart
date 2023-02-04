import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeCubit.dart';
import 'package:shop_app1/Modules/HomeCubit/HomeStatus.dart';
import 'package:shop_app1/Modules/Login_Screen.dart';
import 'package:shop_app1/network/Cach_Helper.dart';

class Settings extends StatelessWidget {
  var key = GlobalKey<FormState>();
  var contphone = TextEditingController();
  var contname = TextEditingController();
  var contemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contname.text = ShopAppHomeCubit.get(context).userModel!.data!.name!;
    contemail.text = ShopAppHomeCubit.get(context).userModel!.data!.email!;
    contphone.text = ShopAppHomeCubit.get(context).userModel!.data!.phone!;
    return BlocConsumer<ShopAppHomeCubit, ShopAppHomeStates>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: ConditionalBuilder(
                  condition: state != ShopAppShowproLoadingState(),
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              if(state is ShopAppUpDateLoadingState)
                                LinearProgressIndicator(
                                  color: Colors.black,
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: contname,
                                validator: (index) {
                                  if (index!.isEmpty) {
                                    return 'we must not be empty ';
                                  }
                                },
                                decoration: InputDecoration(
                                    suffix: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Name',
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.black))),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: contemail,
                                validator: (index) {
                                  if (index!.isEmpty) {
                                    return 'we must not be empty ';
                                  }
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Email',
                                    suffix: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.black))),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: contphone,
                                validator: (index) {
                                  if (index!.isEmpty) {
                                    return 'we must not be empty ';
                                  }
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    labelText: 'Phone',
                                    suffix: Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.black))),
                              ),
                              SizedBox(
                                height: 25,
                              ), Container(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ShopAppHomeCubit.get(context).GetUpDate(name: contname.text, Email: contemail.text, Phone: contphone.text);
                                  },
                                  child: Text(
                                    'UpDate',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        CachHelper.removeData(key: 'token')
                                            .then((value) {
                                          if(value){
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()),
                                                    (route) => false);
                                          }
                                        });
                                      },
                                      child: Text(
                                        'LogOut',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.redAccent),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                  fallback: (context) => CircularProgressIndicator(
                    color: Colors.black,
                  )));
        },
        listener: (context, state) {});
  }
}
