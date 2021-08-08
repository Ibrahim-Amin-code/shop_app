import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter111/models/shop_app/categories_model.dart';
import 'package:udemy_flutter111/models/shop_app/change_favorites_model.dart';
import 'package:udemy_flutter111/models/shop_app/favorites_model.dart';
import 'package:udemy_flutter111/models/shop_app/home_model.dart';
import 'package:udemy_flutter111/models/shop_app/login_model.dart';
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
  Map<int , bool> favourites = {};
  // bool fav = false;
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel.data.banners[0].image);
      // print(homeModel.status);
      homeModel.data.products.forEach((element) {
        favourites.addAll({
          element.id : element.inFavorites,
        });
      });



      print(favourites.toString());

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


  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId)
  {

    favourites[productId] = !favourites[productId];
    emit(ShopSuccessChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if(!changeFavoritesModel.status)
      {
        favourites[productId] = !favourites[productId];
      }else
      {
        getFavorites();
      }

      print(value.data);

      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {

      favourites[productId] = !favourites[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJon(value.data);
      print(userModel.data.name);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  })
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },

    ).then((value) {
      userModel = ShopLoginModel.fromJon(value.data);
      print(userModel.data.name);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}