import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/http/log_utils.dart';
import '../model/goods.dart';
import '../provide/CategoryProvider.dart';
import '../routers/application.dart';
import '../routers/routers.dart';
import '../http/http_utils.dart';
import '../model/category.dart';
import '../config/index.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

CategoryModel categoryModel;
List<CategoryItem> categoryList;
List<SubCategoryItem> subCategoryList;
GoodsModel goodsModel;
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
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    if (categoryList != null) {
      return Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoods(),
              ],
            )
          ],
        ),
      );
    } else {
      return noDataWidget();
    }
  }

  _getCategoryList() {
    HttpUtils.getCategoryList(
        null,
        (data) => {
              setState(() {
                categoryModel = CategoryModel.fromJson(data);
                categoryList = categoryModel.datas;
                subCategoryList = categoryList[0].subList;
                Provider.of<CategoryProvider>(context)
                    .changeSubCategory(0, subCategoryList[0].subId);
                Provider.of<CategoryProvider>(context)
                    .setSubCategoryList(categoryList[0].subList);
                if (Provider.of<CategoryProvider>(context).isNotifyGoodsList) {
                  Provider.of<CategoryProvider>(context)
                      .changeCategory(0, categoryList[0].id);
                  Provider.of<CategoryProvider>(context)
                      .setNotifyGoodsList(true);
                }
                _getCategoryGoodsList(context);
              })
            },
        (code, msg) => null);
  }
}

_getCategoryGoodsList(context) {
  var param = {
    "page": Provider.of<CategoryProvider>(context).page,
    "category": Provider.of<CategoryProvider>(context).categoryId,
    "sub_category": Provider.of<CategoryProvider>(context).subCategoryId
  };
  LogUtils.print_("0000000" + param.toString());
  HttpUtils.getCategoryGoodsList(
      param,
      (data) => {
            goodsModel = GoodsModel.fromJson(data),
            Provider.of<CategoryProvider>(context)
                .setGoodsList(goodsModel.datas)
          },
      (code, msg) => null);
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
    categoryIndex = Provider.of<CategoryProvider>(context).categoryIndex;
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
            Provider.of<CategoryProvider>(context)
                .changeCategory(index, item.id);
            Provider.of<CategoryProvider>(context)
                .setSubCategoryList(categoryList[index].subList);
            categoryIndex =
                Provider.of<CategoryProvider>(context).categoryIndex;
            subCategoryIndex = 0;
            _getCategoryGoodsList(context);
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    subCategoryList = Provider.of<CategoryProvider>(context).subCategoryList;
    return Container(
      color: Colors.black12,
      width: ScreenUtil().setWidth(750 - 180),
      height: ScreenUtil().setHeight(60),
      child: Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subCategoryList.length,
            itemBuilder: (context, index) {
              return _subCategoryItem(subCategoryList[index], index, context);
            }),
      ),
    );
  }

  Widget _subCategoryItem(SubCategoryItem item, index, context) {
    return InkWell(
      onTap: () {
        //Item点击
        setState(() {
          Provider.of<CategoryProvider>(context)
              .changeSubCategory(index, item.subId);
          subCategoryIndex =
              Provider.of<CategoryProvider>(context).subCategoryIndex;
          _getCategoryGoodsList(context);
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
class CategoryGoods extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryGoodsState();
  }
}

class CategoryGoodsState extends State<CategoryGoods> {
  //滚动控制

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<GoodsItem> goodsList =
        Provider.of<CategoryProvider>(context).goodsList;
    if (goodsList.length == 0) {
      return noDataWidget();
    }
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750 - 180),
      height: ScreenUtil().setHeight(1006),
      child: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: goodsList.length,
            itemBuilder: (context, index) {
              return _goodsItem(goodsList[index], index, context);
            }),
      ),
    );
  }

  Widget _goodsItem(GoodsItem item, int index, context) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, Routers.goodsDetailsPage + "?id=${item.id}");
      },
      child: Container(
        padding: EdgeInsets.all(5),
        height: ScreenUtil().setHeight(200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _goodsImage(item),
            Container(
              height: ScreenUtil().setHeight(200),
              child: Stack(
                children: <Widget>[
                  _goodsName(item),
                  Positioned(
                    bottom: 0,
                    child: _goodsPrice(item),
                  ),
                ],
              ),
            )

//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//
//              ],
//            )
          ],
        ),
      ),
    );
  }

  //商品图片
  Widget _goodsImage(GoodsItem item) {
    return Container(
      width: ScreenUtil().setHeight(200),
      child: Image.network(
        item.cover,
        fit: BoxFit.fill,
      ),
    );
  }

  //商品名称
  Widget _goodsName(GoodsItem item) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      width: ScreenUtil().setWidth(350),
      child: Expanded(
          child: Text(
        item.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      )),
    );
  }

  //商品价格
  Widget _goodsPrice(GoodsItem item) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '￥${item.presentPrice}',
            style: KFont.prePriceStyle,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              '￥${item.originalPrice}',
              style: KFont.oriPriceStyle,
            ),
          ),
        ],
      ),
    );
  }
}
