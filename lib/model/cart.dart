class CartModel {
  int code;
  String msg;
  List<CartItem> datas;

  CartModel({this.code, this.msg, this.datas});

  CartModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['datas'] != null) {
      datas = new List<CartItem>();
      json['datas'].forEach((v) {
        datas.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  int id;
  int gId;
  String gName;
  int gNum;
  bool isSelect = false;
  String gCover;
  dynamic presentPrice;
  dynamic originalPrice;

  CartItem(
      {this.id,
        this.gId,
        this.gName,
        this.gNum,
        this.isSelect,
        this.gCover,
        this.presentPrice,
        this.originalPrice});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gId = json['g_id'];
    gName = json['g_name'];
    gNum = json['g_num'];
    isSelect = json['isSelect'];
    gCover = json['g_cover'];
    presentPrice = json['present_price'];
    originalPrice = json['original_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['g_id'] = this.gId;
    data['g_name'] = this.gName;
    data['g_num'] = this.gNum;
    data['isSelect'] = this.isSelect;
    data['g_cover'] = this.gCover;
    data['present_price'] = this.presentPrice;
    data['original_price'] = this.originalPrice;
    return data;
  }
}