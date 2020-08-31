import 'package:flutter/cupertino.dart';
import 'package:shop_flutter/http/http_utils.dart';
import 'package:shop_flutter/model/cart.dart';

class CartProvider with ChangeNotifier {
  int num = 0;
  CartModel cartModel;

  bool isAllSelect = true;

  List<CartItem> cartList;
  dynamic totalPrice = 0.00;

  setCartNum(int cartNum) {
    num = cartNum;
    notifyListeners();
  }

  addCart() {
    num++;
    notifyListeners();
  }

  void getCartList() {
    var param = {"u_id": "1"};
    HttpUtils.getCartList(
        param,
        (data) => {
              cartModel = CartModel.fromJson(data),
              cartList = cartModel.datas,
            },
        (code, msg) => null);
    notifyListeners();
  }

  void setTotalPrice(List<CartItem> list) {
    totalPrice = 0;
    for (CartItem item in list) {
      totalPrice += item.gNum * item.presentPrice;
    }
  }
}
