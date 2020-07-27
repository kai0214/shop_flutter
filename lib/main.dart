import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/pages/IndexPage.dart';
import './provide/CategoryProvider.dart';
import './provide/CurrentIndexProvider.dart';
import './config/index.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: CurrentIndexProvider()),
      ChangeNotifierProvider.value(value: CategoryProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: KString.homeTitle, //首页
        debugShowCheckedModeBanner: false,
        //定制主题
        theme: ThemeData(primaryColor: KColor.primaryColor),
        home: IndexPage(),
      ),
    );
  }
}
