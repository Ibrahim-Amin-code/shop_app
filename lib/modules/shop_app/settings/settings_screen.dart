import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter111/shared/components/components.dart';
import 'package:udemy_flutter111/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state)
      {
        if(state is ShopSuccessUserDataState)
        {
          // nameController.text = state.loginModel.data.name;
          // emailController.text = state.loginModel.data.email;
          // phoneController.text = state.loginModel.data.phone;

        }
      },

      builder: (context , state){

        var model = ShopCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null ,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),

                  SizedBox(
                    height: 20,
                  ),
                  defaultFormFiled(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (String value)
                    {
                      if(value.isEmpty){
                        return 'name must not e empty ';
                      }else{
                        return null;
                      }
                    },
                    label: "Name",
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormFiled(
                    controller: emailController,
                    type: TextInputType.text,
                    validate: (String value)
                    {
                      if(value.isEmpty){
                        return 'email must not e empty ';
                      }else{
                        return null;
                      }
                    },
                    label: "Email Address",
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormFiled(
                    controller: phoneController,
                    type: TextInputType.text,
                    validate: (String value)
                    {
                      if(value.isEmpty){
                        return 'phone must not e empty ';
                      }else{
                        return null;
                      }
                    },
                    label: "Phone Number",
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                    function: ()
                    {
                      signOut(context);
                    },
                    text: 'Sign Out',
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                    function: ()
                    {
                      if(formKey.currentState.validate())
                      {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }

                    },
                    text: 'Update',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()) ,

        );
      } ,

    );
  }
}
