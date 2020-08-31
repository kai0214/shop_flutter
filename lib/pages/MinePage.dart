import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_flutter/config/color.dart';
import '../config/index.dart';

class MinePage extends StatefulWidget {
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          children: <Widget>[
            Image.network(
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596108419697&di=5e3091ccb832c3a3951009558aac64a2&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1305%2F03%2Fc0%2F20496484_1367549048818.jpg",
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setHeight(400),
              fit: BoxFit.fill,
            ),
            Container(
              width: ScreenUtil().setWidth(750),
              color: KColor.white,
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: _item("我的订单"),
                    onTap: () {
                      showToast("我的订单");
                    },
                  ),
                  InkWell(
                    child: _item("收货地址"),
                    onTap: () {
                      showToast("收货地址");
                    },
                  ),
                  InkWell(
                    child: _item("关于我们"),
                    onTap: () {
                      showToast("关于我们");
                    },
                  ),
                  InkWell(
                    child: _item("关于我们"),
                    onTap: () {
                      showToast("关于我们");
                    },
                  ),
                  InkWell(
                    child: _item("关于我们"),
                    onTap: () {
                      showToast("关于我们");
                    },
                  ),
                  InkWell(
                    child: _item("关于我们"),
                    onTap: () {
                      showToast("关于我们");
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _item(String title) {
    return Container(
      height: ScreenUtil().setHeight(100),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 2, color: KColor.backgroundColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${title}",
            style: TextStyle(fontSize: 17),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: KColor.TB1B1B1,
          )
        ],
      ),
    );
  }
}
