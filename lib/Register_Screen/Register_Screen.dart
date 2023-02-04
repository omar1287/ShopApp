
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app1/Componnent/const.dart';
import 'package:shop_app1/Modules/Home.dart';
import 'package:shop_app1/Modules/Login_Screen.dart';
import 'package:shop_app1/Register_Screen/Cubit/ShopAppRegisterState.dart';
import 'package:shop_app1/Register_Screen/Cubit/ShopAppRigesterCubit.dart';
import 'package:shop_app1/network/Cach_Helper.dart';

class Register extends StatelessWidget {

  var forKey=GlobalKey<FormState>();
  var PassWordControll = TextEditingController();
  var NameControll = TextEditingController();
  var PhoneControll = TextEditingController();
  var EmailControll = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create:(context)=>ShopAppRegisterCubit(),
    child: BlocConsumer<ShopAppRegisterCubit,ShopAppRegisterState>(builder:(context,state){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
          }, icon: Icon(
            Icons.arrow_back,color: Colors.black,size: 40,
          )),
        ),
        body: Form(
          key: forKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Register',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800

                  ),),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(

                      controller: NameControll,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must be not empty';
                        }
                      },

                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black)),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ))),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(

                      controller: EmailControll,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'E=Mail must be not empty';
                        }
                      },

                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black)),
                          labelText: 'E-Mail',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ))),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(

                      controller: PassWordControll,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must be not empty';
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black)),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                          ))),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(

                      controller: PhoneControll,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone must be not empty';
                        }
                      },

                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.black)),
                          labelText: 'Phone',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.phone_android,
                              color: Colors.black,
                            ),
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                    condition: state is! ShopAppRegLoadingState,
                    builder: (context) => Center(
                      child: Container(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: ()  {
                            if (forKey.currentState!.validate()) {
                              ShopAppRegisterCubit.get(context).putReg(
                                  Email: EmailControll.text,
                                  Pass: PassWordControll.text,
                                Phone: PhoneControll.text,
                                Name: NameControll.text


                              );
                            }
                          },
                          child: Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

    }, listener: (context,state){
      if (state is ShopAppRegSucssesState) {
        if (state.registerModel.status!) {
          print(state.registerModel.message);
          print(state.registerModel.data?.token);

          CachHelper.SetData(
              key: 'token', value: state.registerModel.data?.token)
              .then((value) {
            Token = state.registerModel.data!.token!;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
          });
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              msg: "${state.registerModel.message}",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else if (state is ShopAppRegErrorState) {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG,
            msg: "${state.registerModel.message}",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

    }),

    );
  }
}
