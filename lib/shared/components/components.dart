
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter111/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0,
  @required Function function,
  @required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultTextButton({
  @required Function function,
  @required String text,

}) => TextButton(
    onPressed: function,
    child: Text(text.toUpperCase()));




Widget defaultFormFiled({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onChange,
  Function onSubmit,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      validator: validate,
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              icon: Icon(Icons.check_box),
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              color: Colors.green,
            ),
            IconButton(
              icon: Icon(Icons.archive),
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );

Widget taskBuilder({
  @required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet Please Add Some Tasks...',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    );



//
// customCachedNetworkImage({String url, BuildContext context}) {
//
//   try {
//     if (url == null || url == '') {
//       return Container(
//         child: Icon(Icons.error),
//         // Image.asset("lib/images/logo icon.png"),
//       );
//     } else {
//       return Container(
//         color: Colors.transparent,
//         width: MediaQuery.of(context).size.width,
//         child: (Uri.parse(url).isAbsolute)
//             ? CachedNetworkImage(
//                 imageUrl: url,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) =>
//                     Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               )
//             : Icon(Icons.error),
//       );
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }

//
// Widget buildArticleItem(article, BuildContext context) => InkWell(
//       onTap: ()
//       {
//         navigateTo(context, WebViewScreen('${article['url']}'));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 image: DecorationImage(
//                   image: NetworkImage('${article['urlToImage']}'),
//                   fit: BoxFit.cover
//                 )
//               ),
//               // child: ClipRRect(
//               //   borderRadius: BorderRadius.circular(20),
//               //   child: customCachedNetworkImage(
//               //     url: '${article['urlToImage']}',
//               //     context: context,
//               //   ),
//               // ),
//
//               //     child: CachedNetworkImage(
//
//               //       imageUrl: '${article['urlToImage']}',
//
//               //       placeholder: (context, url) => CircularProgressIndicator(),
//
//               //       errorWidget: (context, url, error) => Icon(Icons.error),
//
//               //     ),
//
//               //
//
//               // height: 120,
//
//               // width: 120,
//
//               // decoration: BoxDecoration(
//
//               //     borderRadius: BorderRadius.circular(10),
//
//               //     image: DecorationImage(
//
//               //         image: NetworkImage(
//
//               //                '${article['urlToImage']}',
//
//               //            ),
//
//               //       fit: BoxFit.cover,
//
//               //     )
//
//               // ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120,
//                 child: Column(
//                   // mainAxisSize: MainAxisSize.min,
//
//                   crossAxisAlignment: CrossAxisAlignment.start,
//
//                   mainAxisAlignment: MainAxisAlignment.start,
//
//                   children: [
//                     Expanded(
//                       child: Text(
//                         '${article['title']}',
//                         style: Theme.of(context).textTheme.bodyText1,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Text(
//                       '${article['publishedAt']}',
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//
// Widget articleBuilder(list, context ,{isSearch = false}) => ConditionalBuilder(
//       condition: list.length > 0,
//       builder: (context) => ListView.separated(
//           physics: BouncingScrollPhysics(),
//           itemBuilder: (context, index) =>
//               buildArticleItem(list[index], context),
//           separatorBuilder: (context, index) => myDivider(),
//           itemCount: 10),
//       fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
//     );


void navigateTo(context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));


void navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (Route<dynamic> route) => false,
);

 void showToast({
  @required String text,
  @required ToastState state,
}) =>  Fluttertoast.showToast(
   msg: text,
   toastLength: Toast.LENGTH_LONG,
   gravity: ToastGravity.BOTTOM,
   timeInSecForIosWeb: 5,
   backgroundColor: chooseToastColor(state),
   textColor: Colors.white,
   fontSize: 16.0,
 );

 enum ToastState {SUCCESS, ERROR, WARNING}

 Color chooseToastColor(ToastState state)
 {
   Color color;
   switch (state)
   {
     case ToastState.SUCCESS : color = Colors.green;
     break;
     case ToastState.ERROR : color = Colors.red;
     break;
     case ToastState.WARNING : color = Colors.amber;
     break;
     return color;
   }
 }