import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter111/models/shop_app/categories_model.dart';
import 'package:udemy_flutter111/models/shop_app/home_model.dart';
import 'package:udemy_flutter111/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
        builder:(context , state)
        {
         return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null ,
            builder: (context) => productsBuilder(ShopCubit.get(context).homeModel , ShopCubit.get(context).categoriesModel),
           fallback: (context) => Center(child: CircularProgressIndicator()) ,
          );
        },
    );
  }

  Widget productsBuilder(HomeModel model ,CategoriesModel categoriesModel ) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        itemBuilder: (context , index) => buildCategoryItem(categoriesModel.data.data[index]),
                        separatorBuilder: (context , index) => SizedBox(width: 10,),
                        itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.5,
                children: List.generate(model.data.products.length,
                    (index) => buildGridProduct(model.data.products[index])),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image:
      NetworkImage(
          model.image),
        width: 100 ,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
          color: Colors.black.withOpacity(0.6),
          width: 100,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white
            ),
          )),
    ],
  );

  Widget buildGridProduct(Products products) => Container(
    margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(products.image),
                  width: 200,
                  height: 200,
                   fit: BoxFit.contain,
                ),
                if (products.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(

              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, height: 1.1),
                  ),
                  Row(
                    children: [
                      Text(
                        '${products.price.round()}',
                        style: TextStyle(
                          fontSize: 15,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (products.discount != 0)
                        Text(
                          '${products.oldPrice.round()}',
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border),
                        // iconSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
