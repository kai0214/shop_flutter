class GoodsList {
  int code;
  String msg;
  List<GoodsItem> list;

  GoodsList({this.code, this.msg, this.list});

  GoodsList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['list'] != null) {
      list = new List<GoodsItem>();
      json['list'].forEach((v) {
        list.add(new GoodsItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoodsItem {
  int id;
  String name;
  String describe;
  String cover;
  String presentPrice;
  String originalPrice;

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
