import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/Register_Screen/Cubit/ShopAppRegisterState.dart';
import 'package:shop_app1/models/RedModel.dart';
import 'package:shop_app1/models/ShopLoginModel.dart';
import 'package:shop_app1/network/DioHelper.dart';

class ShopAppRegisterCubit extends Cubit<ShopAppRegisterState>{

  ShopAppRegisterCubit():super(ShopAppRegIntialState());

  static ShopAppRegisterCubit get(context)=>BlocProvider.of(context);

  RegisterModel ?registerModel;
  void putReg({required String ?Name ,required String? Phone,required String? Pass,required String? Email}){
    emit(ShopAppRegLoadingState());
    DioHelper.postData(url: 'register', data:{
      "name":Name,
      "phone":Phone,
      "password":Pass,
      "email":Email,


    }).then((value){

      registerModel=  RegisterModel.fromJson(value!.data);
      print(registerModel?.message);
      print(registerModel?.status);
      print(registerModel!.data!.token);
      emit(ShopAppRegSucssesState(registerModel!));
    }).catchError((e){
      emit(ShopAppRegErrorState(e.toString(),registerModel!));
      print( e.toString());
    });


  }

}


