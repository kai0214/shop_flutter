import 'package:flutter/cupertino.dart';
import 'package:shop_flutter/model/category.dart';
import 'package:shop_flutter/model/goods.dart';

//分类Provide
class CategoryProvide with ChangeNotifier {
  List<SubCategoryItem> subCategoryList = [];
  int subCategoryIndex = 0; //二级分类索引
  int categoryIndex = 0; //一级分类索引
  String subCategoryId = ''; //二级分类ID
  String categoryId = ''; //一级分类id
  int page = 1; //列表页数，当改变一级分类或二级分类时进行改变
  String noMoreText = ''; //显示更多的表示
  bool isNewCategory = true;

  //首页点击类别时更改类别
  changeCategory(int index, String id) {
    categoryId = id;
    categoryIndex = index;
    subCategoryId = '';
    notifyListeners();
  }

  //改变子类别
  changeSubCategory(int index, String id) {
    isNewCategory = true;
    subCategoryIndex = index;
    subCategoryId = id;
    page = 1;
    notifyListeners();
  }

  getSubCategoryList(List<SubCategoryItem> list) {
    subCategoryIndex = 0;
    subCategoryId = "";
    subCategoryList = list;
    notifyListeners();
  }

  addPage() {
    page++;
  }
}
