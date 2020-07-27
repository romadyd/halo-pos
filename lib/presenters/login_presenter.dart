import 'package:halopos/data/rest_ds.dart';
import 'package:halopos/models/account_model.dart';

abstract class LoginContract {
  void onLoginSuccess(ResponseAccount user);
  void onLoginError(String msg);
}

class LoginPresenter {
  LoginContract _view;
  RestDatasource api = new RestDatasource();

  LoginPresenter(this._view);

  doLogin(String username, String password) {
    api.login(username, password).then((ResponseAccount response) {
      if (response.status) {
        _view.onLoginSuccess(response);
      } else {
        _view.onLoginError('Pastikan username dan password anda benar!');
      }
    }).catchError((error) => _view.onLoginError(error.toString()));
  }
}