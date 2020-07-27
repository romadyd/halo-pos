
import 'package:halopos/data/database_helper.dart';
import 'package:halopos/data/rest_ds.dart';
import 'package:halopos/models/area_model.dart';
import 'package:halopos/models/business_model.dart';
import 'package:halopos/models/business_type_model.dart';
import 'package:halopos/models/response_model.dart';

abstract class BusinessFormContract {
  void showLoading();
  void hideLoading();
  void onGetBusinessTypeSuccess(ResponseBusinessTypeList entities);
  void onGetAreaSuccess(int level, ResponseAreaList entities);
  void onCreateSuccess(ResponseBusiness entities);
  void onUpdateSuccess(ResponseBusiness entities);
  void onDeleteSuccess(ResponseModel entity);
  void showMessage(String msg);
}

class BusinessFormPresenter {
  BusinessFormContract _view;
  RestDatasource api = new RestDatasource();
  DatabaseHelper db;
  String sessionToken;

  BusinessFormPresenter(this._view) {
    setupInit();
  }

  Future<void> setupInit() async {
    db = new DatabaseHelper();
    await db.getUserSession().then((obj) {
      sessionToken = obj.token;
    });
  }

  getBusinessTypeList() {
    _view.showLoading();
    api.getAllBusinessType().then((ResponseBusinessTypeList response) {
      if (response.status) {
        _view.onGetBusinessTypeSuccess(response);
      } else {
        _view.showMessage('Gagal mengambil Business Type!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.showMessage(error.toString());
      _view.hideLoading();
    });
  }

  getAreaByLevel(int level) {
    api.getAreaByLevel(level).then((ResponseAreaList response) {
      if (response.status) {
        _view.onGetAreaSuccess(level, response);
      } else {
        _view.showMessage('Gagal mengambil Area!');
      }
    }).catchError((error) {
      _view.showMessage(error.toString());
    });
  }

  getAreaByParentId(int level, String parentId) {
    api.getAreaByParentId(parentId).then((ResponseAreaList response) {
      if (response.status) {
        _view.onGetAreaSuccess(level, response);
      } else {
        _view.showMessage('Gagal mengambil Area!');
      }

    }).catchError((error) {
      _view.showMessage(error.toString());
    });
  }

  createBusiness(Business request) {
    _view.showLoading();
    api.createBusiness(sessionToken, request).then((ResponseBusiness response) {
      if (response.status) {
        _view.onCreateSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Business!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }

  updateBusiness(Business request) {
    _view.showLoading();
    api.updateBusiness(sessionToken, request).then((ResponseBusiness response) {
      if (response.status) {
        _view.onUpdateSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Business!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }

  deleteBusiness(Business request) {
    _view.showLoading();
    api.deleteBusiness(sessionToken, request).then((ResponseModel response) {
      if (response.status) {
        _view.onDeleteSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Business!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }
}