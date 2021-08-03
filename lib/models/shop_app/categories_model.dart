// import 'dart:convert';
//
// class CategoriesModel
// {
//   bool states;
//   CategoriesDataModel data;
//
//   CategoriesModel.fromJson(Map<String , dynamic> json)
//   {
//     states = json['states'];
//     data = CategoriesDataModel.fromJson(json['data']);
//
//   }
//
// }
//
// class CategoriesDataModel
// {
//   int currentPage;
//   List<DataModel> data = [];
//
//
//   CategoriesDataModel.fromJson(Map<String , dynamic> json)
//   {
//     currentPage = json['current_page'];
//
//     json['data'].ForEach((element)
//     {
//       data.add(DataModel.fromJson(element));
//     });
//
//   }
// }
//
// class DataModel
// {
//   int id;
//   String name;
//   String image;
//
//   DataModel.fromJson(Map<String , dynamic> json)
//   {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//   }
// }

class CategoriesModel {
  bool status;
  Null message;
  CategoryDataModel data;

  CategoriesModel({this.status, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CategoryDataModel.fromJson(json['data']) : null;
  }

}

class CategoryDataModel {
  int currentPage;
  List<DataModel> data;

  CategoryDataModel(
      {this.currentPage,
        this.data,
      });

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<DataModel>();
      json['data'].forEach((v) {
        data.add(new DataModel.fromJson(v));
      });
    }
  }

}

class DataModel  {
  int id;
  String name;
  String image;

  DataModel({this.id, this.name, this.image});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}