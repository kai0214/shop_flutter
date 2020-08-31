import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'index.dart';

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: "${msg}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: KColor.primaryColor,
      textColor: Colors.white,
      fontSize: ScreenUtil().setSp(30));
}
