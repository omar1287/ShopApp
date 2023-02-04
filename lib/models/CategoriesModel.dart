class CategoriesModel{
  bool ?status;
CategoriesDataModel ?data;

  CategoriesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=CategoriesDataModel.fromJson(json['data']);

  }
}
class CategoriesDataModel{
  int? current_page;
  List<Data1Model>data=[];
  CategoriesDataModel.fromJson(Map<String,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((e){
      data.add(Data1Model.fromJson(e));
    });
  }

}
class Data1Model{
  int ?id;
  String ?name;
  String ?image;
  Data1Model.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];

  }

}
