import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter111/models/shop_app/favorites_model.dart';
import 'package:udemy_flutter111/shared/components/components.dart';
import 'package:udemy_flutter111/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){} ,
      builder: (context , state){
        return  ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            // shrinkWrap: true,
            itemBuilder: (context , index) => buildListProduct(ShopCubit.get(context).favoritesModel.data.data[index].product , context),
            separatorBuilder: (context , index) =>myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ) ,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }





}


/*
* ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        itemBuilder: (context , index) => buildCategoryItem(categoriesModel.data.data[index]),
                        separatorBuilder: (context , index) => SizedBox(width: 10,),
                        itemCount: categoriesModel.data.data.length,
                    )*/