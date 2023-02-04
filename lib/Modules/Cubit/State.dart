import 'package:shop_app1/models/ShopLoginModel.dart';

abstract class ShopAppStates{}
class ShopAppIntialState extends ShopAppStates{}
class ShopAppLoadingState extends ShopAppStates{}
class ShopAppSucssesState extends ShopAppStates{
  UserModel Loginmodel;
  ShopAppSucssesState(this.Loginmodel);

}
class ShopAppErrorState extends ShopAppStates{
  final String e;
  UserModel Loginmodel;
  ShopAppErrorState( this.e,this.Loginmodel);
}
