import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/goods_details/GoodsDetailsPage.dart';

Handler goodsDetailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String goodsId = parameters["id"].first;
  return GoodsDetailsPage(goodsId);
});
