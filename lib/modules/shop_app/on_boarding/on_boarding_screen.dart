
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter111/modules/shop_app/shop_login_screen/shop_login_screen.dart';
import 'package:udemy_flutter111/shared/components/components.dart';
import 'package:udemy_flutter111/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter111/shared/styles/colors.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
});
}

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {

  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'images/shopping_1.jpg',
      title: 'on Board 1 Title',
      body: 'on Board 1 Body',
    ),
    BoardingModel(
      image: 'images/shopping_1.jpg',
      title: 'on Board 2 Title',
      body: 'on Board 2 Body',
    ),
    BoardingModel(
      image: 'images/shopping_1.jpg',
      title: 'on Board 3 Title',
      body: 'on Board 3 Body',
    ),
  ];

  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {


    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: submit,
              text: 'skip',
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(

              child: PageView.builder(
                physics: BouncingScrollPhysics(),
              controller:boardController ,
              onPageChanged: (int index)
              {
                if(index == boarding.length - 1)
                {
                  setState(() {
                    isLast = true;
                  });
                }else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }
              },
              itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
              itemCount:boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect:ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                  ) ,
                ),
                Spacer(),
                FloatingActionButton(onPressed: ()
                {
                  if(isLast)
                  {
                    submit();
                  }else{
                    boardController.nextPage(
                      duration: Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                  },
                  child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text('${model.title}',

        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
      SizedBox(
        height: 15,
      ),
      Text('${model.body}',

        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),),
      SizedBox(
        height: 15,
      ),
    ],
  );
}
