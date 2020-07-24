import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../config/index.dart';
import 'CartPage.dart';
import 'CategoryPage.dart';
import 'MinePage.dart';
import '../provide/CurrentIndexProvide.dart';
import 'HomePage.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  var selectIndex = 0;
  List<Widget> tabBodies = [HomePage(), CategoryPage(), CartPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.init(context, width: 750, height: 1334);
    return Provide<CurrentIndexProvide>(
      builder: (context, child, val) {
        //获取当前索引状态值
        int currentIndex =
            Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: KColor.backgroundColor,
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items: [
                BottomNavigationBarItem(
                    //首页
                    icon: Icon(
                      Icons.home,
                      color: KColor.norColor,
                    ),
                    activeIcon: Icon(
                      Icons.home,
                      color: KColor.delColor,
                    ),
                    title: Text(
                      KString.homeTabStr,
                      style: TextStyle(
                          color: selectIndex != 0
                              ? KColor.norColor
                              : KColor.delColor),
                    )),
                BottomNavigationBarItem(
                    //分类
                    icon: Icon(
                      Icons.category,
                      color: KColor.norColor,
                    ),
                    activeIcon: Icon(
                      Icons.category,
                      color: KColor.delColor,
                    ),
                    title: Text(
                      KString.categoryTabStr,
                      style: TextStyle(
                          color: selectIndex != 1
                              ? KColor.norColor
                              : KColor.delColor),
                    )),
                BottomNavigationBarItem(
                    //购物车
                    icon: Icon(
                      Icons.shopping_cart,
                      color: KColor.norColor,
                    ),
                    activeIcon: Icon(
                      Icons.shopping_cart,
                      color: KColor.delColor,
                    ),
                    title: Text(
                      KString.cartTabStr,
                      style: TextStyle(
                          color: selectIndex != 2
                              ? KColor.norColor
                              : KColor.delColor),
                    )),
                BottomNavigationBarItem(
                    //会员中心
                    icon: Icon(
                      Icons.person,
                      color: KColor.norColor,
                    ),
                    activeIcon: Icon(
                      Icons.person,
                      color: KColor.delColor,
                    ),
                    title: Text(
                      KString.mineTabStr,
                      style: TextStyle(
                          color: selectIndex != 3
                              ? KColor.norColor
                              : KColor.delColor),
                    )),
              ],
              onTap: (index) {
                setState(() {
                  selectIndex = index;
                  Provide.value<CurrentIndexProvide>(context)
                      .changeIndex(index);
                });
              }),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      },
    );
  }
}
