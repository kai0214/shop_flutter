import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/config/index.dart';
import 'package:shop_flutter/config/utils.dart';
import 'package:shop_flutter/provide/GoodsDetailsProvider.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var isLeft = Provider.of<GoodsDetailsProvider>(context).isLeft;
    var path =
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596117820318&di=06017fa76e7821214ad0198d7963acca&imgtype=0&src=http%3A%2F%2Fwx1.sinaimg.cn%2Forj360%2F6fe6b187ly1ge2q8udju6j20ku45qkjl.jpg";
    if (isLeft) {
      return Container(
        child: Html(
          data: getWebImage(path),
        ),
      );
    } else {
      return noDataWidget();
    }
  }
}
