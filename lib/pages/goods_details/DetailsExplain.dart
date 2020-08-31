import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:shop_flutter/config/font.dart';

class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
      alignment: Alignment.centerLeft,
      child: Text("说明 > 记载 > 好东西",style: KFont.prePriceStyle,),
    );
  }
}
