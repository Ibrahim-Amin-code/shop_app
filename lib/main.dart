
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter111/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter111/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter111/modules/shop_app/shop_login_screen/shop_login_screen.dart';
import 'package:udemy_flutter111/shared/bloc_observer.dart';
import 'package:udemy_flutter111/shared/components/constants.dart';
import 'package:udemy_flutter111/shared/cubit/cubit.dart';
import 'package:udemy_flutter111/shared/cubit/states.dart';
import 'package:udemy_flutter111/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter111/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter111/shared/styles/themes.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized(); //طالما ان ال void main  بقت async وفيها ميثود  await  فلازم هنه ال Widget دي

  Bloc.observer = MyBlocObserver();

  DioHelper.inti();

  await CacheHelper.init();

  // bool isDark = CacheHelper.getData(key: 'isDark');

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');

  Widget widget;

  token = CacheHelper.getData(key: 'token');

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  }else {
    widget = OnBoardScreen();
  }

  runApp(MyApp(
    // isDark: isDark,
    startWidget : widget,
  ));
}

class MyApp extends StatelessWidget
{
  // final bool isDark;
  final Widget startWidget;

  MyApp({
    // this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:
      [
        // BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        // BlocProvider(
        //   create: (BuildContext context) => AppCubit()
        //     ..changeAppMode(
        //       fromShared: isDark,
        //     ),
        // ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode:
            // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: SafeArea(child: startWidget,),
          );
        },
      ),
    );
  }
}