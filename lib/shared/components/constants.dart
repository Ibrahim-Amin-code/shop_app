
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=85967d8af8d34e0c85fdcb5e846217a7


// base Url : https://newsapi.org/
// method Url : v2/top-headlines?
// queries : country=eg&category=business&apiKey=85967d8af8d34e0c85fdcb5e846217a7


// https://newsapi.org/v2/everything?q=w&from=2021-06-23&sortBy=publishedAt&apiKey=85967d8af8d34e0c85fdcb5e846217a7 (this api of searching)

//https://newsapi.org/v2/everything?q=w&apiKey=85967d8af8d34e0c85fdcb5e846217a7


import 'package:udemy_flutter111/modules/shop_app/shop_login_screen/shop_login_screen.dart';
import 'package:udemy_flutter111/shared/network/local/cache_helper.dart';
import 'components.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the sizeof each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';