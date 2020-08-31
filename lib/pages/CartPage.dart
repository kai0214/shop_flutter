import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/config/index.dart';
import 'package:shop_flutter/http/http_utils.dart';
import 'package:shop_flutter/model/cart.dart';
import 'package:shop_flutter/provide/CartProvider.dart';

class CartPage extends StatefulWidget {
  _CartPageState createState() => _CartPageState();
}

CartModel cartModel;

class _CartPageState extends State<CartPage> {
  List<CartItem> cartList;

  @override
  void initState() {
    // TODO: implement initState
    _getCartList();
    super.initState();
  }

  void _getCartList() {
    var param = {"u_id": "1"};
    HttpUtils.getCartList(
        param,
        (data) => {
              cartModel = CartModel.fromJson(data),
              cartList = cartModel.datas,
            },
        (code, msg) => null);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    Provider.of<CartProvider>(context).getCartList();

//    cartList = Provider.of<CartProvider>(context).cartList;
    Provider.of<CartProvider>(context).setTotalPrice(cartList);

    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    if (cartList != null) {
      return Stack(
        children: <Widget>[
          Container(
            color: KColor.backgroundColor,
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
            width: ScreenUtil().setWidth(750),
            child: CartGoodsWidget(cartList),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                color: KColor.white,
                height: ScreenUtil().setHeight(90),
                width: ScreenUtil().setWidth(750),
                child: _cartBottomWidget(context),
              ))
        ],
      );
    } else {
      return noDataWidget();
    }
  }
}

Widget _cartBottomWidget(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 10),
        child: InkWell(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.adjust,
                color: Provider.of<CartProvider>(context).isAllSelect
                    ? KColor.delColor
                    : KColor.norColor,
              ),
              Text(" 全选")
            ],
          ),
        ),
      ),
      Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                "总价：¥${Provider.of<CartProvider>(context).totalPrice}",
                style: KFont.prePriceStyle,
              ),
              margin: EdgeInsets.only(right: 10),
            ),
            InkWell(
              onTap: () {
                showToast("购买");
              },
              child: Container(
                color: KColor.delColor,
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setHeight(90),
                child: Center(
                  child: Text(
                    "购买",
                    style: TextStyle(color: KColor.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

class CartGoodsWidget extends StatefulWidget {
  List<CartItem> cartList;

  CartGoodsWidget(this.cartList);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartGoodsWidgetState(cartList);
  }
}

class CartGoodsWidgetState extends State<CartGoodsWidget> {
  List<CartItem> cartList;

  CartGoodsWidgetState(this.cartList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (cartList.length == 0) {
      return noDataWidget();
    }
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          return _goodsItem(cartList[index], index, context);
        });
  }

  Widget _goodsItem(CartItem item, index, context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 5, top: 3, bottom: 3, right: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _goodsCover(item),
            Container(
              padding: EdgeInsets.only(left: 5),
              width: ScreenUtil().setWidth(530),
              height: ScreenUtil().setHeight(200),
              child: Stack(
                children: <Widget>[_goodsName(item), _stackBottom(item)],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _goodsCover(CartItem item) {
    return Image.network(
      item.gCover,
      height: ScreenUtil().setHeight(200),
      width: ScreenUtil().setWidth(200),
      fit: BoxFit.fill,
    );
  }

  Widget _goodsName(CartItem item) {
    return Container(
      child: Text(
        '${item.gName}',
        maxLines: 2,
      ),
    );
  }

  Widget _stackBottom(CartItem item) {
    return Positioned(
        bottom: 0,
        width: ScreenUtil().setWidth(520),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[_goodsPrice(item), _goodsNum(item)],
        ));
  }

  Widget _goodsPrice(CartItem item) {
    return Container(
      child: Text(
        '￥${item.presentPrice}',
        maxLines: 2,
        style: KFont.prePriceStyle,
      ),
    );
  }

  Widget _goodsNum(CartItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          onTap: () {
            _addGoods(context, item.id, item.gNum - 1);
          },
          child: Icon(
            Icons.indeterminate_check_box,
            color: KColor.primaryColor,
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(80),
          child: Center(
            child: Text('${item.gNum}'),
          ),
        ),
        InkWell(
          onTap: () {
            _addGoods(context, item.id, item.gNum + 1);
          },
          child: Icon(
            Icons.add_box,
            color: KColor.primaryColor,
          ),
        ),
      ],
    );
  }

  void _addGoods(context, id, num) {
    var param = {"u_id": "1", "g_id": id, "g_num": num};
    HttpUtils.postAddCart(
        param, (data) => {setState(() {})}, (code, msg) => {});
  }
}
