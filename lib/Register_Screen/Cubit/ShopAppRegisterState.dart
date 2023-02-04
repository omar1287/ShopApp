import 'package:shop_app1/models/RedModel.dart';
import 'package:shop_app1/models/ShopLoginModel.dart';

abstract class ShopAppRegisterState{}
class ShopAppRegIntialState extends ShopAppRegisterState{}
class ShopAppRegLoadingState extends ShopAppRegisterState{}
class ShopAppRegSucssesState extends ShopAppRegisterState{
  RegisterModel registerModel;
  ShopAppRegSucssesState(this.registerModel);

}
class ShopAppRegErrorState extends ShopAppRegisterState{
  final String e;
  RegisterModel registerModel;
  ShopAppRegErrorState( this.e,this.registerModel);
}
