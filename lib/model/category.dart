class CategoryModel {
  int code;
  String msg;
  List<CategoryItem> datas;

  CategoryModel({this.code, this.msg, this.datas});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['datas'] != null) {
      datas = new List<CategoryItem>();
      json['datas'].forEach((v) {
        datas.add(new CategoryItem.fromJson(v));
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

class CategoryItem {
  int id;
  String name;
  List<SubCategoryItem> subList;

  CategoryItem({this.id, this.name, this.subList});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['subList'] != null) {
      subList = new List<SubCategoryItem>();
      json['subList'].forEach((v) {
        subList.add(new SubCategoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.subList != null) {
      data['subList'] = this.subList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryItem {
  int id;
  int subId;
  String subName;

  SubCategoryItem({this.id, this.subId, this.subName});

  SubCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subId = json['sub_id'];
    subName = json['sub_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['sub_name'] = this.subName;
    return data;
  }
}
