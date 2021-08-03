import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/models/shop_app/login_model.dart';
import 'package:udemy_flutter111/modules/shop_app/shop_login_screen/cubit/states.dart';
import 'package:udemy_flutter111/shared/network/remote/end_points.dart';
import 'package:udemy_flutter111/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

 static ShopLoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;


   ShopLoginModel loginModel;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState ());
  }


 void userLogin({
  @required String email,
  @required String password,
})
 {
   emit(ShopLoginLoadingState());
   DioHelper.postData(
       url: LOGIN,
       data: {
         'email':email,
         'password':password,
       },).then((value) {
          // print(value.data);
         loginModel = ShopLoginModel.fromJon(value.data);

         // loginModel = ShopLoginModel.fromJson(value.data);
         // print(loginModel.status);
         // print(loginModel.message);
         // print(loginModel.data.token);
         emit(ShopLoginSuccessState(loginModel));
   }).catchError((error){
     print('error is $error ');
     emit(ShopLoginErrorState(error.toString()));
   });
 }


}