import 'package:flutter/cupertino.dart';
import 'package:shop_flutter/model/category.dart';
import 'package:shop_flutter/model/goods.dart';

//分类Provide
class CategoryProvider with ChangeNotifier {
  List<SubCategoryItem> subCategoryList = [];
  int subCategoryIndex = 0; //二级分类索引
  int categoryIndex = 0; //一级分类索引
  int subCategoryId = 0; //二级分类ID
  int categoryId = 0; //一级分类id
  int page = 1; //列表页数，当改变一级分类或二级分类时进行改变
  String noMoreText = ''; //显示更多的表示
  bool isNewCategory = true;
  List<GoodsItem> goodsList = [];

  //首页点击类别时更改类别
  changeCategory(int index, int id) {
    categoryIndex = index;
    categoryId = id;
    subCategoryId = 0;
    subCategoryIndex = 0;
    page = 1;
    notifyListeners();
  }

  //改变子类别
  changeSubCategory(int index, int id) {
    isNewCategory = true;
    subCategoryIndex = index;
    subCategoryId = id;
    page = 1;
    notifyListeners();
  }

  setSubCategoryList(List<SubCategoryItem> list) {
    subCategoryIndex = 0;
    subCategoryId = 0;
    subCategoryList = list;
    notifyListeners();
  }

  addPage() {
    page++;
    notifyListeners();
  }

  setGoodsList(List<GoodsItem> list) {
    goodsList = list;
    notifyListeners();
  }
}
