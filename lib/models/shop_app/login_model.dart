class ShopLoginModel
{
  bool status;
  String message;
  UserData data;

  ShopLoginModel.fromJon(Map<String , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJon(json['data']) : null;
  }
}

class UserData
{
  int id;
  String name;
  String email;
  String phone;
  String image;
  String token;
  int points;
  int credit;

  // UserData({
  // this.credit,
  // this.email,
  // this.id,
  // this.image,
  // this.name,
  // this.phone,
  // this.token,
  // this.points,
  // });

  UserData.fromJon(Map<String , dynamic> json)
  {
    id = json['id'];
    credit = json['credit'];
    email = json['email'];
    image = json['image'];
    name = json['name'];
    phone = json['phone'];
    token = json['token'];
    points = json['points'];
  }


}






















// class ShopLoginModel
// {
//   bool status;
//   String message;
//   UserData data;
//
//   ShopLoginModel.fromJson(Map<String , dynamic> json)
//   {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null? UserData.fromJson(json['data']) : null;
//
//   }
//
// }
//
// class UserData
// {
//   int id;
//   String name;
//   String email;
//   String phone;
//   String image;
//   String token;
//   int point;
//   int credit;
// //
// //   UserData({
// //     this.token,
// //     this.email,
// //     this.image,
// //     this.id,
// //     this.name,
// //     this.phone,
// //     this.credit,
// //     this.point,
// // });
//
//   // named constructor
//
//   UserData.fromJson(Map<String , dynamic> json)
//   {
//     id = json['id'];
//     token = json['token'];
//     credit = json['credit'];
//     point = json['point'];
//     phone = json['phone'];
//     image = json['image'];
//     name = json['name'];
//     email = json['email'];
//   }
//
// }