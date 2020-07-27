
class GoodsModel {
  int code;
  String msg;
  List<GoodsItem> datas;

  GoodsModel({this.code, this.msg, this.datas});

  GoodsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['datas'] != null) {
      datas = new List<GoodsItem>();
      json['datas'].forEach((v) {
        datas.add(new GoodsItem.fromJson(v));
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

class GoodsItem {
  int id;
  String name;
  String describe;
  String cover;
  dynamic presentPrice;
  dynamic originalPrice;

  GoodsItem(
      {this.id,
        this.name,
        this.describe,
        this.cover,
        this.presentPrice,
        this.originalPrice});

  GoodsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    describe = json['describe'];
    cover = json['cover'];
    presentPrice = json['present_price'];
    originalPrice = json['original_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['describe'] = this.describe;
    data['cover'] = this.cover;
    data['present_price'] = this.presentPrice;
    data['original_price'] = this.originalPrice;
    return data;
  }
}
