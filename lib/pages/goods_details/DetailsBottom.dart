import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/config/color.dart';
import 'package:shop_flutter/http/http_utils.dart';
import 'package:shop_flutter/http/log_utils.dart';
import 'package:shop_flutter/model/goods_details.dart';
import 'package:shop_flutter/provide/CartProvider.dart';
import 'package:shop_flutter/provide/CurrentIndexProvider.dart';
import 'package:shop_flutter/config/index.dart';

class DetailsBottom extends StatefulWidget {
  GoodsDetails goodsDetails;

  DetailsBottom(this.goodsDetails);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailsBottomState(goodsDetails);
  }
}

class DetailsBottomState extends State<DetailsBottom> {
  GoodsDetails goodsDetails;

  DetailsBottomState(this.goodsDetails);

  void _addCart(context, id) {
    var param = {"u_id": "1", "g_id": id};
    HttpUtils.postAddCart(
        param,
        (data) => {
              setState(() {
                Provider.of<CartProvider>(context).addCart();
              })
            },
        (code, msg) => {
              setState(() {
                showToast(msg);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var num = Provider.of<CartProvider>(context).num;
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              //TODO 跳转到购物车页面
              Provider.of<CurrentIndexProvider>(context).changeIndex(2);
              Navigator.pop(context);
            },
            child: Stack(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(110),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: KColor.primaryColor,
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.only(left: 3, right: 3),
                      decoration: BoxDecoration(
                        color: KColor.detailsTabTextDelColor,
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "${num}",
                        style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                      ),
                    ))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              //TODO 加入购物车
              _addCart(context, goodsDetails.id);
            },
            child: Container(
              color: Colors.blue,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              alignment: Alignment.center,
              child: Text(
                "加入购物车",
                style: TextStyle(color: KColor.white),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              //TODO 马上购买
            },
            child: Container(
              color: Colors.redAccent,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              alignment: Alignment.center,
              child: Text(
                "马上购买",
                style: TextStyle(color: KColor.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
