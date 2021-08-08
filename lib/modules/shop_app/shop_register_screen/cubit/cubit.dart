import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/models/shop_app/login_model.dart';
import 'package:udemy_flutter111/modules/shop_app/shop_register_screen/cubit/states.dart';
import 'package:udemy_flutter111/shared/network/remote/end_points.dart';
import 'package:udemy_flutter111/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

 static ShopRegisterCubit get(context) => BlocProvider.of(context);


  ShopLoginModel loginModel;

 void userRegister({
  @required String email,
  @required String password,
  @required String name,
  @required String phone,
})
 {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
       url: REGISTER,
       data: {
         'email':email,
         'password':password,
         'name':name,
         'phone':phone,
       },).then((value) {
          // print(value.data);
         loginModel = ShopLoginModel.fromJon(value.data);
         emit(ShopRegisterSuccessState(loginModel));
   }).catchError((error){
     print('error is $error ');
     print('------------------------------------------- error is $error');
     emit(ShopRegisterErrorState(error.toString()));
   });
 }



  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }


}