
import 'package:halopos/data/database_helper.dart';
import 'package:halopos/data/rest_ds.dart';
import 'package:halopos/models/product_model.dart';
import 'package:halopos/models/response_model.dart';

abstract class ProductContract {
  void showLoading();
  void hideLoading();
  void onGetProductSuccess(ResponseProductList entities);
  void onDeleteSuccess(ResponseModel entity);
  void showMessage(String msg);
}

class ProductPresenter {
  ProductContract _view;
  RestDatasource api = new RestDatasource();
  DatabaseHelper db;
  String sessionToken;

  ProductPresenter(this._view){
    setupInit();
  }

  Future<void> setupInit() async {
    db = new DatabaseHelper();
    await db.getUserSession().then((obj) {
      sessionToken = obj.token;
    });
  }

  getAllProduct(Product request) {
    _view.showLoading();
    api.getAllProduct(sessionToken, request).then((ResponseProductList response) {
      if (response.status) {
        _view.onGetProductSuccess(response);
      } else {
        _view.showMessage('Gagal mengambil kategori!');
      }

      _view.hideLoading();
    }).catchError((error) {
      _view.showMessage(error.toString());
      _view.hideLoading();
    });
  }

  deleteProduct(Product request) {
    _view.showLoading();
    api.deleteProduct(sessionToken, request).then((ResponseModel response) {
      if (response.status) {
        _view.onDeleteSuccess(response);
      } else {
        _view.showMessage('Gagal menghapus Business!');
      }

      _view.hideLoading();
      getAllProduct(request);
    }).catchError((error) {
      _view.hideLoading();
      _view.showMessage(error.toString());
    });
  }
}