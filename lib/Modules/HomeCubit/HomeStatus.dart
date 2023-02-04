import 'package:shop_app1/models/FavoritesModel.dart';

abstract class ShopAppHomeStates{}
class ShopAppHomeIntialState extends ShopAppHomeStates{}
class ShopAppHomeLoadingState extends ShopAppHomeStates{}

class ShopAppHomeSucssesState extends ShopAppHomeStates{
}
class ShopAppHomeErrorState extends ShopAppHomeStates{
}
class ShopAppHomeChangeScreens extends ShopAppHomeStates{}
class ShopAppCateErrorState extends ShopAppHomeStates{
}
class ShopAppCateSucssesState extends ShopAppHomeStates{

}
class ShopAppFavErrorState extends ShopAppHomeStates{

}
class ShopAppFavSucssesState extends ShopAppHomeStates{
FavoritesModel favoritesModel;
ShopAppFavSucssesState({required this.favoritesModel});
}
class ShopAppFavChange extends ShopAppHomeStates{}
class ShopAppgetfavSucssesState extends ShopAppHomeStates{
}
class ShopAppgetfavErrorState extends ShopAppHomeStates{}
class ShopAppgetfavLoadingState extends ShopAppHomeStates{}
class ShopAppShowproSucssesState extends ShopAppHomeStates{
}
class ShopAppShowproErrorState extends ShopAppHomeStates{}
class ShopAppShowproLoadingState extends ShopAppHomeStates{}
class ShopAppUpDateSucssesState extends ShopAppHomeStates{
}
class ShopAppUpDateErrorState extends ShopAppHomeStates{}
class ShopAppUpDateLoadingState extends ShopAppHomeStates{}
