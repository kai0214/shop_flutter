import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shop_flutter/config/font.dart';
import 'package:shop_flutter/model/goods_details.dart';

class DetailsTop extends StatelessWidget {
  GoodsDetails goodsDetails;

  DetailsTop(this.goodsDetails);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BannerWidget(
            bannerList: goodsDetails.images,
          ),
          _goodsName(goodsDetails),
          _goodsPrice(goodsDetails),
        ],
      ),
    );
  }
}

Widget _goodsName(GoodsDetails goodsDetails) {
  return Container(
    padding: EdgeInsets.all(5),
    child: Text(
      goodsDetails.name,
    ),
  );
}

Widget _goodsPrice(GoodsDetails goodsDetails) {
  return Container(
    padding: EdgeInsets.only(left: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          '￥${goodsDetails.presentPrice}',
          style: KFont.prePriceStyle,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            '￥${goodsDetails.originalPrice}',
            style: KFont.oriPriceStyle,
          ),
        ),
      ],
    ),
  );
  ;
}

//轮播图
class BannerWidget extends StatelessWidget {
  final List<String> bannerList;

  const BannerWidget({Key key, this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(500),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Image.network(
              "${bannerList[index]}",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: bannerList.length,
        pagination: SwiperPagination(),
      ),
    );
  }
}
