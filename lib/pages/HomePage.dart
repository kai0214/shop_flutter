import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/model/category.dart';
import 'package:shop_flutter/provide/CategoryProvider.dart';
import 'package:shop_flutter/provide/CurrentIndexProvider.dart';
import '../http/http_utils.dart';
import '../model/goods.dart';
import '../config/index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

int page = 1;

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  //防止刷新处理  保持当前状态
  List<GoodsItem> goodsList;

  List<CategoryItem> categoryList;

  @override
  bool get wantKeepAlive => true;

  void getGoodsList(page) {
    GoodsModel goods;
    HttpUtils.getGoodsList<GoodsModel>(
        {"page": page},
        (data) => {
              setState(() {
                goods = GoodsModel.fromJson(data);
                if (page == 1) {
                  if (goodsList != null) {
                    goodsList.clear();
                  }
                  goodsList = goods.datas;
                } else {
                  goodsList.addAll(goods.datas);
                }
              })
            },
        (code, msg) => null);
  }

  void getGoodsCategory() {
    CategoryModel categoryModel;
    HttpUtils.getCategoryList(
        null,
        (data) => {
              categoryModel = CategoryModel.fromJson(data),
              categoryList = categoryModel.datas,
            },
        (code, msg) => null);
  }

  @override
  void initState() {
    // TODO: implement initState
    getGoodsList(page);
    getGoodsCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KColor.backgroundColor,
        appBar: AppBar(
          title: Text(KString.homeTitle),
        ),
        body: getWidget(goodsList));
  }

  Widget getWidget(List<GoodsItem> goodsList) {
    if (goodsList != null) {
      return EasyRefresh(
        footer: ClassicalFooter(),
        header: ClassicalHeader(),
        child: ListView(
          children: <Widget>[
            SwiperDiy(
              swiperDataList: goodsList,
            ),
            TopNavBar(
              navBarList: categoryList,
            ),
            GoodsRecommend(
              recommendList: goodsList,
            ),
            FloorPic(
              item: goodsList[0],
            ),
            HotGoodsWidget(
              hotGoodsList: goodsList,
            )
          ],
        ),
        onLoad: () async {
          page++;
//        content.getGoodsList(page);
        },
        onRefresh: () async {
          page = 1;
//        content.getGoodsList(page);
        },
      );
    } else {
      return loadingWidget();
    }
  }
}

//轮播图
class SwiperDiy extends StatelessWidget {
  final List<GoodsItem> swiperDataList;

  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Image.network(
              "${swiperDataList[index].cover}",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//首页分类导航
class TopNavBar extends StatelessWidget {
  final List<CategoryItem> navBarList;

  const TopNavBar({Key key, this.navBarList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (navBarList.length > 10) {
      navBarList.removeRange(10, navBarList.length);
    }
    int tempIndex = -1;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(10),
      height: ScreenUtil().setHeight(330),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(), //禁止滚动
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navBarList.map((e) {
          tempIndex++;
          return _gridViewItem(context, e, tempIndex);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItem(BuildContext context, CategoryItem item, index) {
    return InkWell(
      onTap: () {
        //跳转
        _goCategory(context, index, item.id, item);
      },
      child: Column(
        children: <Widget>[
          Image.network(
            "coveritem.",
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setHeight(90),
          ),
          Text(item.name)
        ],
      ),
    );
  }

  //跳转到分类页面
  void _goCategory(context, int index, int categoryId, CategoryItem item) {
    Provider.of<CategoryProvider>(context).changeCategory(index, categoryId);
    Provider.of<CategoryProvider>(context).setSubCategoryList(item.subList);
    Provider.of<CurrentIndexProvider>(context).changeIndex(1);
  }
}

//商品推荐
class GoodsRecommend extends StatelessWidget {
  final List<GoodsItem> recommendList;

  const GoodsRecommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }

  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(400),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (content, index) {
          return _item(recommendList[index], content);
        },
      ),
    );
  }

  Widget _item(GoodsItem item, content) {
    return InkWell(
        onTap: () {
          //Item点击
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 0.5, color: KColor.primaryColor),
            ),
          ),
          height: ScreenUtil().setHeight(380),
          width: ScreenUtil().setWidth(350),
          margin: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Expanded(
            //防止溢出
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  item.cover,
                  height: ScreenUtil().setHeight(280),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("现价：" + item.presentPrice.toString(),
                      style: TextStyle(fontSize: 13.0),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "原价：" + item.originalPrice.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  //商品推荐标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(7),
      child: Text("精品推荐"),
    );
  }
}

//中间广告位
class FloorPic extends StatelessWidget {
  final GoodsItem item;

  const FloorPic({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(5),
      child: InkWell(
        child: Image.network(
          item.cover,
          fit: BoxFit.cover,
        ),
        onTap: () {},
      ),
    );
  }
}

class HotGoodsWidget extends StatelessWidget {
  final List<GoodsItem> hotGoodsList;

  const HotGoodsWidget({Key key, this.hotGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[hotTitle(), HotGoodsGrid()],
      ),
    );
  }

  //火爆专区标题
  Widget hotTitle() => Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.5, color: KColor.primaryColor),
          ),
        ),
        //火爆专区
        child: Text(
          "火爆专区",
          style: TextStyle(color: KColor.primaryColor),
        ),
      );

  Widget HotGoodsGrid() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: _buildList(),
    );
  }

  List<Widget> _buildList() {
    return hotGoodsList.map((e) => _item(e)).toList();
  }

  Widget _item(GoodsItem item) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(352),
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(bottom: 3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              item.cover,
              width: ScreenUtil().setWidth(375),
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: ScreenUtil().setSp(26)),
            ),
            Row(
              children: <Widget>[
                Text(
                  '￥${item.presentPrice}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(20.0),
                      color: KColor.primaryColor),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    '￥${item.originalPrice}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20.0),
                      color: KColor.primaryColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
