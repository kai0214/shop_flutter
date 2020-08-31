import 'dart:convert';

import 'package:shop_flutter/config/http_conf.dart';
import 'package:shop_flutter/config/toast.dart';
import 'package:shop_flutter/http/error_handle.dart';

import 'dio_utils.dart';
import 'log_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

class HttpUtils {
  //TODO 登陆
  static void login<T>(parameters, Success success, Fail fail) {
    post(HttpConf.login, parameters, success: success, fail: fail);
  }

  //TODO 获取商品列表
  static void getGoodsList<T>(param, Success success, Fail fail) {
    get(HttpConf.goodsList, param, success: success, fail: fail);
  }

  //TODO 通过分类获取商品列表
  static void getCategoryGoodsList<T>(param, Success success, Fail fail) {
    get(HttpConf.categoryGoodsList, param, success: success, fail: fail);
  }

  //todo 获取商品详情
  static void getGoodsDetails<T>(param, Success success, Fail fail) {
    get(HttpConf.goodsDetails, param, success: success, fail: fail);
  }

  //TODO 获取分类列表
  static void getCategoryList<T>(param, Success success, Fail fail) {
    get(HttpConf.categoryList, param, success: success, fail: fail);
  }

  //TODO 添加购物车
  static void postAddCart<T>(param, Success success, Fail fail) {
    post(HttpConf.addCart, param, success: success, fail: fail);
  }

  //TODO 获取购物车列表
  static void getCartList<T>(param, Success success, Fail fail) {
    get(HttpConf.cartList, param, success: success, fail: fail);
  }

  /********************************* 分割线 ********************************/

  static void get<T>(String url, parameters, {Success success, Fail fail}) {
    _request(Method.GET, url, parameters, success: success, fail: fail);
  }

  static void post<T>(String url, parameters, {Success success, Fail fail}) {
    _request(Method.POST, url, parameters, success: success, fail: fail);
  }

  static void delete<T>(String url, parameters, {Success success, Fail fail}) {
    _request(Method.DELETE, url, parameters, success: success, fail: fail);
  }

  static void put<T>(String url, parameters, {Success success, Fail fail}) {
    _request(Method.PUT, url, parameters, success: success, fail: fail);
  }

  //_request 请求
  static void _request<T>(
    Method method,
    String url,
    parameters, {
    Success success,
    Fail fail,
  }) {
    /// restful 请求处理
    /// /base/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /base/search/hist/27
//    parameters.forEach((key, value) {
//      if (url.indexOf(key) != -1) {
//        url = url.replaceAll(':$key', value.toString());
//      }
//    });
//    //参数处理
//    LogUtils.d("--------- parameters ---------");
    LogUtils.d("$parameters");

    LogUtils.print_("-----url : $url   ->  $parameters");
    DioUtils.request(method, url, parameters, success: (result) {
//      LogUtils.d("--------- response ---------");
      LogUtils.print_(result.toString());
      if (ExceptionHandle.success == result['code']) {
        if (success != null) {
          success(result);
        }
      } else {
        if (fail != null) {
          showToast(result['msg']);
          fail(result['code'], result['msg']);
        }
      }
    }, fail: (code, msg) {
//      JhProgressHUD.showError(msg);
      if (fail != null) {
        fail(code, msg);
      }
    });
  }
}
