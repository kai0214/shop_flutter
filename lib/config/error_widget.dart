import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget setErrWidget(int errCode) {
  if (errCode == 0) {
    return Center(
      child: Column(
        children: <Widget>[Icon(Icons.cached), Text("暂无数据")],
      ),
    );
  }
}

Widget loadingWidget() {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.cached),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text("正在加载···"),
          )
        ],
      ),
    ),
  );
}

Widget noDataWidget() {
  return Expanded(
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.not_interested),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text("暂无数据···"),
        )
      ],
    )),
  );
}
