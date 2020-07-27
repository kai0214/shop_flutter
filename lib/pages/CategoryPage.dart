import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/provide/CategoryProvide.dart';
import '../http/http_utils.dart';
import '../model/category.dart';
import '../config/index.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

Category category;
List<CategoryItem> categoryList;
List<SubCategoryItem> subCategoryList;
int categoryIndex = 0;
int subCategoryIndex = 0;


class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    _getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: _getWidget(),
    );
  }

  Widget _getWidget() {
    if (categoryList != null) {
      return Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[],
            )
          ],
        ),
      );
    } else {
      return Center(
        child: Text("错误"),
      );
    }
  }

  _getCategoryList() {
    HttpUtils.getCategoryList(
        null,
        (data) => {
              setState(() {
                category = Category.fromJson(data);
                categoryList = category.data;
                subCategoryList = categoryList[categoryIndex].subList;
//            _provide.getSubCategoryList(categoryList[categoryIndex].subList);
              })
            },
        (code, msg) => null);
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LeftCategoryNavState();
  }
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
          border:
              Border(right: BorderSide(width: 1, color: KColor.primaryColor)),
        ),
        child: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return _categoryItem(categoryList[index], index, context);
            }));
  }

  Widget _categoryItem(CategoryItem item, index, context) {
    return InkWell(
        onTap: () {
          //Item点击
          setState(() {
            categoryIndex = index;
            subCategoryIndex = 0;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 0.5, color: KColor.primaryColor),
            ),
          ),
          child: Container(
              height: 30,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 5),
              child: Text(
                item.name,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(25),
                    color:
                        categoryIndex == index ? Colors.amber : Colors.black),
              )),
        ));
  }
}

class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RightCategoryNavState();
  }
}

//右侧菜单分类
class _RightCategoryNavState extends State<RightCategoryNav> {
  void _changePage(CategoryItem item) {
    setState(() {
      subCategoryList = item.subList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: ScreenUtil().setWidth(750 - 180),
        child: Container(
          child: Consumer<CategoryProvide>(
              builder: (context, categoryProvide, widget) {
            subCategoryList = categoryProvide.subCategoryList;
            return Container(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subCategoryList.length,
                  itemBuilder: (context, index) {
                    return _subCategoryItem(
                        subCategoryList[index], index, context);
                  }),
            );
          }),
        ));
  }

  Widget _subCategoryItem(SubCategoryItem item, index, context) {
    return InkWell(
      onTap: () {
        //Item点击
        setState(() {
          subCategoryIndex = index;
        });
      },
      child: Container(
          height: 30,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 5),
          child: Text(
            item.subName,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(25),
                color: subCategoryIndex == index ? Colors.blue : Colors.black),
          )),
    );
  }
}

//商品列表
class CategoryGoodsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
