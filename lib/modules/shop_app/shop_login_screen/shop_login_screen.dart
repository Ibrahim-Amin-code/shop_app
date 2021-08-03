import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter111/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter111/modules/shop_app/shop_register_screen/shop_register_screen.dart';
import 'package:udemy_flutter111/shared/components/components.dart';
import 'package:udemy_flutter111/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(

      create: (BuildContext context) => ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
        listener:(context , state)
        {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(state.loginModel.message)));
              CacheHelper.saveData(key: 'token', value: state.loginModel.data.token,).then((value) {
                navigateAndFinish(context, ShopLayout(),);
              });

            } else {
              print(state.loginModel.message);
              scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(state.loginModel.message)));
              showToast(
                text: state.loginModel.message ,
                state: ToastState.ERROR,
              );
            }
          }
          // if(state is ShopLoginSuccessState)
          // {
          //   if(state.loginModel.status)
          //   {
          //     print(state.loginModel.data.token);
          //     print(state.loginModel.message);
          //
          //     Fluttertoast.showToast(
          //       msg: state.loginModel.message,
          //       toastLength: Toast.LENGTH_LONG,
          //       gravity: ToastGravity.BOTTOM,
          //       timeInSecForIosWeb: 5,
          //       backgroundColor: Colors.green,
          //       textColor: Colors.white,
          //       fontSize: 16.0,
          //     );
          //   }
          //   else
          //   {
          //     print(state.loginModel.message);
          // Fluttertoast.showToast(
          //   msg: state.loginModel.message,
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 5,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
          //   }
          // }
        } ,
        builder :(context , state)
         {
           return Scaffold(
             key: scaffoldKey,
                 appBar: AppBar(),
                 body: Center(
                   child: SingleChildScrollView(
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Form(
                          key: formKey,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('Login',style: Theme.of(context).textTheme.headline4.copyWith(
                                 color: Colors.black
                             ),),
                             SizedBox(
                               height: 15,
                             ),
                             Text('Login now to browse our hot offers',
                               style: Theme.of(context).textTheme.bodyText1.copyWith(
                                   color: Colors.grey
                               ),),
                             SizedBox(
                               height: 40,
                             ),
                             defaultFormFiled(controller: emailController ,
                               type: TextInputType.emailAddress,
                               validate: (String value)
                               {
                                 if(value.isEmpty)
                                 {
                                   return 'Email Must Not Be Empty';
                                 }else{
                                   return null;
                                 }
                               },
                               label: 'Email Address',
                               prefix: Icons.email_outlined,
                             ),

                             SizedBox(
                               height: 20,
                             ),

                             defaultFormFiled(controller: passwordController ,
                               type: TextInputType.visiblePassword,
                               isPassword:ShopLoginCubit.get(context).isPassword ,
                               suffixPressed: ()
                               {
                                  ShopLoginCubit.get(context).changePasswordVisibility();
                               },

                               onSubmit: (value)
                               {

                                 if(formKey.currentState.validate())
                                 {
                                   ShopLoginCubit.get(context).userLogin(
                                     email: emailController.text,
                                     password: passwordController.text,
                                   );
                                   showToast(
                                     text:  ShopLoginCubit.get(context).loginModel.message ,
                                     state: ToastState.ERROR,
                                   );
                                 }
                               },

                               validate: (String value)
                               {
                                 if(value.isEmpty)
                                 {
                                   return 'Password Is Too Short';
                                 }else{
                                   return null;
                                 }
                               },
                               label: 'Password',
                               prefix: Icons.lock,
                               suffix: ShopLoginCubit.get(context).suffix ,
                             ),

                             SizedBox(
                               height: 20,
                             ),

                             ConditionalBuilder(
                               condition: state is! ShopLoginLoadingState,
                               builder: (context) => defaultButton(
                                   function: ()
                                   {
                                     if(formKey.currentState.validate())
                                     {
                                       ShopLoginCubit.get(context).userLogin(
                                         email: emailController.text,
                                         password: passwordController.text,
                                       );
                                     }
                                   },
                                   text: 'Login',
                                   isUpperCase: true),
                                   fallback: (context) => Center(child: CircularProgressIndicator()) ,
                               ),

                             SizedBox(
                               height: 20,
                             ),

                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text('Don\'t Have An Account?'),
                                 defaultTextButton(
                                   function: ()
                                   {
                                     navigateTo(context, ShopRegisterScreen());
                                   },
                                   text: 'register now',
                                 ),
                               ],
                             ),

                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               );
         } ,
      ),
    );
  }
}
