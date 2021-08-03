import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter111/models/shop_app/categories_model.dart';
import 'package:udemy_flutter111/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener:(context, state) {},

      builder: (context, state) {
       return Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemBuilder: (context , index) => buildCateItem(ShopCubit.get(context).categoriesModel.data.data[index]) ,
            separatorBuilder: (context , index) => myDivider() ,
            itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
          ),
        ) ;
      }
    );
  }

Widget buildCateItem(DataModel model) => Row(
  children: [
    Image(image:
    NetworkImage(model.image),
      width: 80,
      height: 80,
      fit: BoxFit.cover ,
    ),
    SizedBox(
      width: 20,
    ),
    Text(
      model.name,style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    ),
    Spacer(),
    Icon(Icons.arrow_forward_ios),
  ],
);

}
