const baseUrl = "http://127.0.0.1:8080/";

const servicePath = {
  'addGoods': baseUrl + 'v1/goods/add', //添加商品
  'getGoodsList': baseUrl + "v1/goods/list" //获取商品
};

class HttpConf {
  static const String BaseUrl = "http://127.0.0.1:8080/";

  //登陆
  static const String login = "v1/account/login";

  //获取商品列表
  static const String goodsList = "v1/goods/list";

  //获取分类列表
  static const String categoryList = "v1/category/list";

  //获取分类商品列表
  static const String categoryGoodsList = "v1/goods/categoryGoodsList";
}
