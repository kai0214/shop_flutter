import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shop_flutter/pages/IndexPage.dart';
import './provide/CurrentIndexProvide.dart';
import './config/index.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();

  providers..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));
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
