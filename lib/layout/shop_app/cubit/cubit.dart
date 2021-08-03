import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter111/models/shop_app/categories_model.dart';
import 'package:udemy_flutter111/models/shop_app/home_model.dart';
import 'package:udemy_flutter111/modules/shop_app/categories/cateogries_screen.dart';
import 'package:udemy_flutter111/modules/shop_app/favourites/favourites_screen.dart';
import 'package:udemy_flutter111/modules/shop_app/products/products_screen.dart';
import 'package:udemy_flutter111/modules/shop_app/settings/settings_screen.dart';
import 'package:udemy_flutter111/shared/components/constants.dart';
import 'package:udemy_flutter111/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter111/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit <ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }


  HomeModel homeModel;

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
     printFullText(homeModel.data.banners[0].image);
     print(homeModel.status);
      // print(homeModel.toString());
      // print(homeModel.status);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      // printFullText(homeModel.data.banners[0].image);
      // print(homeModel.status);
      // // print(homeModel.toString());
      // print(homeModel.status);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }


}