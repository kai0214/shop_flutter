class GoodsDetailsModel {
  int code;
  String msg;
  GoodsDetails data;

  GoodsDetailsModel({this.code, this.msg, this.data});

  GoodsDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data =
        json['data'] != null ? new GoodsDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GoodsDetails {
  int id;
  String name;
  String describe;
  String cover;
  int category;
  int subCategory;
  dynamic presentPrice;
  dynamic originalPrice;
  List<String> images;
  int cartNum;

  GoodsDetails(
      {this.id,
        this.name,
        this.describe,
        this.cover,
        this.category,
        this.subCategory,
        this.presentPrice,
        this.originalPrice,
        this.images,
        this.cartNum});

  GoodsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    describe = json['describe'];
    cover = json['cover'];
    category = json['category'];
    subCategory = json['subCategory'];
    presentPrice = json['present_price'];
    originalPrice = json['original_price'];
    images = json['images'].cast<String>();
    cartNum = json['cart_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['describe'] = this.describe;
    data['cover'] = this.cover;
    data['category'] = this.category;
    data['subCategory'] = this.subCategory;
    data['present_price'] = this.presentPrice;
    data['original_price'] = this.originalPrice;
    data['images'] = this.images;
    data['cart_num'] = this.cartNum;
    return data;
  }
}