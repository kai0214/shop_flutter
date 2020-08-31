import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/pages/IndexPage.dart';
import 'package:shop_flutter/provide/CartProvider.dart';
import 'package:shop_flutter/provide/GoodsDetailsProvider.dart';
import 'package:shop_flutter/routers/application.dart';
import 'package:shop_flutter/routers/routers.dart';
import './provide/CategoryProvider.dart';
import './provide/CurrentIndexProvider.dart';
import './config/index.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: CurrentIndexProvider()),
      ChangeNotifierProvider.value(value: CategoryProvider()),
      ChangeNotifierProvider.value(value: GoodsDetailsProvider()),
      ChangeNotifierProvider.value(value: CartProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
        onGenerateRoute: Application.router.generator,
        title: KString.homeTitle,
        //首页
        debugShowCheckedModeBanner: false,
        //定制主题
        theme: ThemeData(primaryColor: KColor.primaryColor),
        home: IndexPage(),
      ),
    );
  }
}
