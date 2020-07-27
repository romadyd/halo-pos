
import 'package:halopos/data/database_helper.dart';
import 'package:halopos/data/rest_ds.dart';
import 'package:halopos/models/category_model.dart';
import 'package:halopos/models/response_model.dart';

abstract class CategoryFormContract {
  void showLoading();
  void hideLoading();
  void onCreateSuccess(ResponseCategory entities);
  void onUpdateSuccess(ResponseCategory entities);
  void onDeleteSuccess(ResponseModel entity);
  void showMessage(String msg);
}

class CategoryFormPresenter {
  CategoryFormContract _view;
  RestDatasource api = new RestDatasource();
  DatabaseHelper db;
  String sessionToken;

  CategoryFormPresenter(this._view) {
    setupInit();
  }

  Future<void> setupInit() async {
    db = new DatabaseHelper();
    await db.getUserSession().then((obj) {
      sessionToken = obj.token;
    });
  }

  createCategory(Category request) {
    _view.showLoading();
    api.createCategory(sessionToken, request).then((ResponseCategory response) {
      if (response.status) {
        _view.onCreateSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Category!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }

  updateCategory(Category request) {
    _view.showLoading();
    api.updateCategory(sessionToken, request).then((ResponseCategory response) {
      if (response.status) {
        _view.onUpdateSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Category!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }

  deleteCategory(Category request) {
    _view.showLoading();
    api.deleteCategory(sessionToken, request).then((ResponseModel response) {
      if (response.status) {
        _view.onDeleteSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Category!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }
}