import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/config/color.dart';
import 'package:shop_flutter/provide/GoodsDetailsProvider.dart';

class DetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var isLift = Provider.of<GoodsDetailsProvider>(context).isLeft;
    var isRight = Provider.of<GoodsDetailsProvider>(context).isRight;
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      margin: EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[
          _leftWidget(context, isLift),
          _rightWidget(context, isRight)
        ],
      ),
    );
  }

  Widget _leftWidget(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provider.of<GoodsDetailsProvider>(context).changeLeftAndRight("left");
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 2.0,
                    color: isLeft
                        ? KColor.detailsTabTextDelColor
                        : KColor.white))),
        child: Text(
          "详细",
          style: TextStyle(
              color: isLeft
                  ? KColor.detailsTabTextDelColor
                  : KColor.detailsTabTextNorColor),
        ),
      ),
    );
  }

  Widget _rightWidget(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provider.of<GoodsDetailsProvider>(context).changeLeftAndRight("right");
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 2.0,
                    color: isRight
                        ? KColor.detailsTabTextDelColor
                        : KColor.white))),
        child: Text(
          "评论",
          style: TextStyle(
              color: isRight
                  ? KColor.detailsTabTextDelColor
                  : KColor.detailsTabTextNorColor),
        ),
      ),
    );
  }
}
