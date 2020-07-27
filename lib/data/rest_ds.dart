import 'dart:async';

import 'package:halopos/models/account_model.dart';
import 'package:halopos/models/area_model.dart';
import 'package:halopos/models/business_model.dart';
import 'package:halopos/models/business_type_model.dart';
import 'package:halopos/models/category_model.dart';
import 'package:halopos/models/product_model.dart';
import 'package:halopos/models/response_model.dart';
import 'package:halopos/utils/network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://apihp.milogica.com";
  static final LOGIN = BASE_URL + "/user/login";
  static final REGISTRATION = BASE_URL + "/user/registration";
  static final GETUSERBYTOKEN = BASE_URL + "/user/getbytoken";
  static final GETBUSINESSTYPE = BASE_URL + "/businesstype/get";
  static final GETAREABYLEVEL = BASE_URL + "/area/getbylevel";
  static final GETAREABYPARENTID = BASE_URL + "/area/getbyparentid";
  static final GETBUSINESS = BASE_URL + "/business/get";
  static final CREATEBUSINESS = BASE_URL + "/business/create";
  static final UPDATEBUSINESS = BASE_URL + "/business/update";
  static final DELETEBUSINESS = BASE_URL + "/business/delete";
  static final GETCATEGORY = BASE_URL + "/category/get";
  static final CREATECATEGORY = BASE_URL + "/category/create";
  static final UPDATECATEGORY = BASE_URL + "/category/update";
  static final DELETECATEGORY = BASE_URL + "/category/delete";
  static final GETPRODUCT = BASE_URL + "/product/get";
  static final CREATEPRODUCT = BASE_URL + "/product/create";
  static final UPDATEPRODUCT = BASE_URL + "/product/update";
  static final DELETEPRODUCT = BASE_URL + "/product/delete";
  static final _API_KEY = "somerandomkey";

  /* ==== Authentication ==== */
  Future<ResponseAccount> login(String uid, String pwd) {
    return _netUtil.post(LOGIN, body: {
      'mobile': uid,
      'password': pwd
    }).then((dynamic res) {
      return ResponseAccount.fromJson(res);
    });
  }

  Future<ResponseAccount> getByToken(String token) {
    return _netUtil.post(GETUSERBYTOKEN, body: {
      'token': token
    }).then((dynamic res) {
      return ResponseAccount.fromJson(res);
    });
  }

  Future<ResponseAccount> register(Account request) {
    return _netUtil.post(REGISTRATION, body: request.toMap()).then((dynamic res) {
      return ResponseAccount.fromJson(res);
    });
  }

  /* ==== BusinessType ==== */
  Future<ResponseBusinessTypeList> getAllBusinessType() {
    return _netUtil.post(GETBUSINESSTYPE).then((dynamic res) {
      return ResponseBusinessTypeList.map(res);
    });
  }

  /* ==== Area ==== */
  Future<ResponseAreaList> getAreaByLevel(int level) {
    return _netUtil.post(GETAREABYLEVEL, body: {
      'level': level.toString()
    }).then((dynamic res) {
      return ResponseAreaList.map(res);
    });
  }

  Future<ResponseAreaList> getAreaByParentId(String parentId) {
    return _netUtil.post(GETAREABYPARENTID, body: {
      'parentId': parentId
    }).then((dynamic res) {
      return ResponseAreaList.map(res);
    });
  }

  /* ==== Business ==== */
  Future<ResponseBusinessList> getAllBusiness(String token) {
    return _netUtil.post(GETBUSINESS, body: {
      'token': token
    }).then((dynamic res) {
      return ResponseBusinessList.map(res);
    });
  }

  Future<ResponseBusiness> createBusiness(String token, Business entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(CREATEBUSINESS, body: request).then((dynamic res) {
      return ResponseBusiness.map(res);
    });
  }

  Future<ResponseBusiness> updateBusiness(String token, Business entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(UPDATEBUSINESS, body: request).then((dynamic res) {
      return ResponseBusiness.map(res);
    });
  }

  Future<ResponseModel> deleteBusiness(String token, Business entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(DELETEBUSINESS, body: request).then((dynamic res) {
      return ResponseModel.map(res);
    });
  }

  /* ==== Category ==== */
  Future<ResponseCategoryList> getAllCategory(String token, Category entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(GETCATEGORY, body: request).then((dynamic res) {
      return ResponseCategoryList.map(res);
    });
  }

  Future<ResponseCategory> createCategory(String token, Category entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(CREATECATEGORY, body: request).then((dynamic res) {
      return ResponseCategory.map(res);
    });
  }

  Future<ResponseCategory> updateCategory(String token, Category entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(UPDATECATEGORY, body: request).then((dynamic res) {
      return ResponseCategory.map(res);
    });
  }

  Future<ResponseModel> deleteCategory(String token, Category entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(DELETECATEGORY, body: request).then((dynamic res) {
      return ResponseModel.map(res);
    });
  }

  /* ==== Product ==== */
  Future<ResponseProductList> getAllProduct(String token, Product entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(GETPRODUCT, body: request).then((dynamic res) {
      return ResponseProductList.map(res);
    });
  }

  Future<ResponseProduct> createProduct(String token, Product entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(CREATEPRODUCT, body: request).then((dynamic res) {
      return ResponseProduct.map(res);
    });
  }

  Future<ResponseProduct> updateProduct(String token, Product entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(UPDATEPRODUCT, body: request).then((dynamic res) {
      return ResponseProduct.map(res);
    });
  }

  Future<ResponseModel> deleteProduct(String token, Product entity) {
    var request = entity.toMap();
    request['token'] = token;
    return _netUtil.post(DELETEPRODUCT, body: request).then((dynamic res) {
      return ResponseModel.map(res);
    });
  }

}