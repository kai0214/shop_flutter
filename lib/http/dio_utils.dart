import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:shop_flutter/config/http_conf.dart';
import 'error_handle.dart';
import 'log_utils.dart';

const int _connectTimeout = 12000; //连接超时 时间
const int _receiverTimeout = 12000; // 响应超时时间
const int _sendTimeout = 10000; //发送时间

typedef Success<T> = Function(T data); //请求成功返回
typedef Fail = Function(int code, String msg); //请求失败返回
enum Method { GET, POST, DELETE, PUT, PATCH, HEAD }
//使用：MethodValues[Method.POST]
const MethodValues = {
  Method.GET: "get",
  Method.POST: "post",
  Method.DELETE: "delete",
  Method.PUT: "put",
  Method.PATCH: "patch",
  Method.HEAD: "head",
};

class DioUtils {
  static const String TOKEN = ''; //请求的token
  static Dio _dio;

  //创建dio实例对象
  static Dio createInstance() {
    if (_dio == null) {
      //设置全局属性：请求前缀，连接超时时间，响应超时时间
      var options = BaseOptions(
        // 请求的Content-Type，默认值是"application/json; charset=utf-8".
        // 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
        // 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]就会自动编码请求体.
        // contentType: Headers.formUrlEncodedContentType, // 适用于post form表单提交
        responseType: ResponseType.json,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        baseUrl: HttpConf.BaseUrl,
//          headers: , 可以设置请求头
        connectTimeout: _connectTimeout,
        //连接超时时间
        receiveTimeout: _receiverTimeout,
        //响应超时时间
        sendTimeout: _sendTimeout,
      );
      _dio = new Dio(options);
    }
    return _dio;
  }

  //清空dio对象
  static clear() {
    _dio = null;
  }

  //T         请求返回参数类型
  //method    请求方法
  //path      请求地址
  //params    请求参数
  //success   请求成功回调
  //fail      请求失败回调
  static Future request<T>(Method method, String path, dynamic params,
      {Success success, Fail fail}) async {
    try {
      //没有网络
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        _onError(ExceptionHandle.net_error, '网络异常，请检查你的网络！', fail);
        return;
      }
      Dio _dio = createInstance();
      Response response = await _dio.request(path,
          queryParameters: params,
          options: Options(method: MethodValues[method]));
      if (response != null) {
        if (success != null) {
          success(response.data);
        }
      } else {
        _onError(ExceptionHandle.unknown_error, '未知错误', fail);
      }
    } on DioError catch (err) {
      LogUtils.print_('接口请求异常： url: $path, error: ${err.toString()}');
      final NetError netError = ExceptionHandle.handleException(err);
      _onError(netError.code, netError.msg, fail);
    }
  }
}

/// 自定义Header
Map<String, dynamic> httpHeaders = {
  'Accept': 'application/json,*/*',
  'Content-Type': 'application/json',
  'token': DioUtils.TOKEN
};

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

void _onError(int code, String msg, Fail fail) {
  if (code == null) {
    code = ExceptionHandle.unknown_error;
    msg = '未知异常';
  }
  LogUtils.print_('接口请求异常： code: $code, msg: $msg');
  if (fail != null) {
    fail(code, msg);
  }
}
