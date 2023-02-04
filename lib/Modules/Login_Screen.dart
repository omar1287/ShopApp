import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app1/Componnent/const.dart';
import 'package:shop_app1/Modules/Cubit/Cubit.dart';
import 'package:shop_app1/Modules/Cubit/State.dart';
import 'package:shop_app1/Modules/Home.dart';
import 'package:shop_app1/Modules/ShopLayout.dart';
import 'package:shop_app1/Register_Screen/Register_Screen.dart';
import 'package:shop_app1/models/ShopLoginModel.dart';
import 'package:shop_app1/network/Cach_Helper.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var EmailControll = TextEditingController();
    var PassWordControll = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopAppCubit(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
          if (state is ShopAppSucssesState) {
            if (state.Loginmodel.status) {
              print(state.Loginmodel.message);
              print(state.Loginmodel.data?.token);

              CachHelper.SetData(
                      key: 'token', value: state.Loginmodel.data?.token)
                  .then((value) {
                Token = state.Loginmodel.data!.token!;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Shoplayout()),
                    (route) => false);
              });
              Fluttertoast.showToast(
                  toastLength: Toast.LENGTH_LONG,
                  msg: "${state.Loginmodel.message}",
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else if (state is ShopAppErrorState) {
            Fluttertoast.showToast(
                toastLength: Toast.LENGTH_LONG,
                msg: "${state.Loginmodel.message}",
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                            controller: EmailControll,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'E-Mail should be not empty';
                              }
                            },
                            style: TextStyle(color: Colors.black),
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
                                suffix: Icon(Icons.email))),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: PassWordControll,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is short';
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
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopAppLoadingState,
                          builder: (context) => Center(
                            child: Container(
                              width: 350,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    ShopAppCubit.get(context).putEandP(
                                        Email: EmailControll.text,
                                        Pass: PassWordControll.text);
                                  }
                                },
                                child: Text(
                                  'Login',
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
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "If you don't have account?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));                        },
                          child: Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
