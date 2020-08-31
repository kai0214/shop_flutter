import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class KFont {
  //原价文本样式
  static TextStyle oriPriceStyle = TextStyle(
    color: Colors.black26,
    fontSize: ScreenUtil().setSp(28),
    decoration: TextDecoration.lineThrough,
  );

  //现价文本样式
  static TextStyle prePriceStyle = TextStyle(
    color: Colors.red,
    fontSize: ScreenUtil().setSp(34),
  );
}
