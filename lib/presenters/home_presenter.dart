
import 'package:halopos/data/database_helper.dart';
import 'package:halopos/data/rest_ds.dart';
import 'package:halopos/models/business_type_model.dart';
import 'package:halopos/models/category_model.dart';
import 'package:halopos/models/response_model.dart';

abstract class HomeContract {
  void showLoading();
  void hideLoading();
  void onGetCategorySuccess(ResponseCategoryList entities);
  void onDeleteSuccess(ResponseModel entity);
  void showMessage(String msg);
}

class HomePresenter {
  HomeContract _view;
  RestDatasource api = new RestDatasource();
  DatabaseHelper db;
  String sessionToken;

  HomePresenter(this._view){
    setupInit();
  }

  Future<void> setupInit() async {
    db = new DatabaseHelper();
    await db.getUserSession().then((obj) {
      sessionToken = obj.token;
    });
  }

  getAllCategory(Category request) {
    _view.showLoading();
    api.getAllCategory(sessionToken, request).then((ResponseCategoryList response) {
      if (response.status) {
        _view.onGetCategorySuccess(response);
      } else {
        _view.showMessage('Gagal mengambil kategori!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.showMessage(error.toString());
      _view.hideLoading();
    });
  }

  deleteCategory(Category request) {
    _view.showLoading();
    api.deleteCategory(sessionToken, request).then((ResponseModel response) {
      if (response.status) {
        _view.onDeleteSuccess(response);
      } else {
        _view.showMessage('Gagal menghapus Business!');
      }

      _view.hideLoading();
      getAllCategory(request);
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }
}