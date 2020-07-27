
import 'package:halopos/data/database_helper.dart';
import 'package:halopos/data/rest_ds.dart';
import 'package:halopos/models/product_model.dart';
import 'package:halopos/models/response_model.dart';

abstract class ProductFormContract {
  void showLoading();
  void hideLoading();
  void onCreateSuccess(ResponseProduct entities);
  void onUpdateSuccess(ResponseProduct entities);
  void onDeleteSuccess(ResponseModel entity);
  void showMessage(String msg);
}

class ProductFormPresenter {
  ProductFormContract _view;
  RestDatasource api = new RestDatasource();
  DatabaseHelper db;
  String sessionToken;

  ProductFormPresenter(this._view) {
    setupInit();
  }

  Future<void> setupInit() async {
    db = new DatabaseHelper();
    await db.getUserSession().then((obj) {
      sessionToken = obj.token;
    });
  }

  createProduct(Product request) {
    _view.showLoading();
    api.createProduct(sessionToken, request).then((ResponseProduct response) {
      if (response.status) {
        _view.onCreateSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Product!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }

  updateProduct(Product request) {
    _view.showLoading();
    api.updateProduct(sessionToken, request).then((ResponseProduct response) {
      if (response.status) {
        _view.onUpdateSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Product!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }

  deleteProduct(Product request) {
    _view.showLoading();
    api.deleteProduct(sessionToken, request).then((ResponseModel response) {
      if (response.status) {
        _view.onDeleteSuccess(response);
      } else {
        _view.showMessage('Gagal membuat Product!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }
}