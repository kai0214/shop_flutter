import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/config/index.dart';
import 'package:shop_flutter/http/http_utils.dart';
import 'package:shop_flutter/model/goods_details.dart';
import 'package:shop_flutter/pages/goods_details/DetailsBottom.dart';
import 'package:shop_flutter/pages/goods_details/DetailsExplain.dart';
import 'package:shop_flutter/pages/goods_details/DetailsTab.dart';
import 'package:shop_flutter/pages/goods_details/DetailsTop.dart';
import 'package:shop_flutter/pages/goods_details/DetailsWeb.dart';
import 'package:shop_flutter/provide/CartProvider.dart';

class GoodsDetailsPage extends StatefulWidget {
  String goodsId;

  GoodsDetailsPage(this.goodsId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GoodsDetailsPageState(goodsId);
  }
}

GoodsDetailsModel goodsDetailsModel;

class _GoodsDetailsPageState extends State<GoodsDetailsPage> {
  String goodsId;

  _GoodsDetailsPageState(this.goodsId);

  GoodsDetails goodsDetails;

  @override
  void initState() {
    // TODO: implement initState
    _getGoodsDetails();
    super.initState();
  }

  _getGoodsDetails() {
    var param = {"id": goodsId, "u_id": "1"};
    HttpUtils.getGoodsDetails(
        param,
        (data) => {
              setState(() {
                goodsDetailsModel = GoodsDetailsModel.fromJson(data);
                goodsDetails = goodsDetailsModel.data;
                Provider.of<CartProvider>(context).setCartNum(goodsDetails.cartNum);
              })
            },
        (code, msg) => null);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text("商品详情"),
        ),
        body: _bodyWidget());
  }

  Widget _bodyWidget() {
    if (goodsDetails != null) {
      return Stack(
        children: <Widget>[
          Container(
            color: KColor.backgroundColor,
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(82)),
            child: ListView(
              children: <Widget>[
                DetailsTop(goodsDetails),
                DetailsExplain(),
                DetailsTab(),
                DetailsWeb()
              ],
            ),
          ),
          Positioned(bottom: 0, child: DetailsBottom(goodsDetails))
        ],
      );
    } else {
      return loadingWidget();
    }
  }
}
