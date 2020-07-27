
import 'package:halopos/data/database_helper.dart';
import 'package:halopos/data/rest_ds.dart';
import 'package:halopos/models/business_model.dart';
import 'package:halopos/models/response_model.dart';

abstract class BusinessContract {
  void showLoading();
  void hideLoading();
  void onGetBusinessSuccess(ResponseBusinessList entities);
  void onDeleteSuccess(ResponseModel entity);
  void showMessage(String msg);
}

class BusinessPresenter {
  BusinessContract _view;
  RestDatasource api = new RestDatasource();
  DatabaseHelper db;
  String sessionToken;

  BusinessPresenter(this._view) {
    setupInit();
  }

  Future<void> setupInit() async {
    db = new DatabaseHelper();
    await db.getUserSession().then((obj) {
      sessionToken = obj.token;
    });
  }

  getAllBusiness() {
    _view.showLoading();
    api.getAllBusiness(sessionToken).then((ResponseBusinessList response) {
      if (response.status) {
        _view.onGetBusinessSuccess(response);
      } else {
        _view.showMessage('Gagal mengambil Business!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.showMessage(error.toString());
      _view.hideLoading();
    });
  }

  deleteBusiness(Business request) {
    _view.showLoading();
    api.deleteBusiness(sessionToken, request).then((ResponseModel response) {
      if (response.status) {
        _view.onDeleteSuccess(response);
      } else {
        _view.showMessage('Gagal menghapus Business!');
      }

      _view.hideLoading();
      getAllBusiness();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }
}