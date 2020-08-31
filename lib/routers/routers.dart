import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../routers/router_handler.dart';

class Routers {
  static String root = "/";
  static String goodsDetailsPage = "/goodsDetails";

  static void configureRouters(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('error::: router 没有找到');
    });
    router.define(goodsDetailsPage, handler: goodsDetailsHandler);
  }
}
