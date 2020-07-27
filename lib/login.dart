import 'package:flutter/material.dart';
import 'package:halopos/presenters/login_presenter.dart';
import 'package:halopos/providers/auth_provider.dart';
import 'package:halopos/utils/transition.dart';
import 'package:halopos/registration.dart';

import 'data/database_helper.dart';
import 'data/rest_ds.dart';
import 'home.dart';
import 'models/account_model.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    implements LoginContract, AuthStateListener {
  BuildContext _context;
  RestDatasource api = new RestDatasource();

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  String _username, _password;

  LoginPresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void createSnackBar(String message) {
    final snackBar = new SnackBar(content: new Text(message), backgroundColor: Colors.red);
    Scaffold.of(_context).showSnackBar(snackBar);
  }

  void doLogin() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  @override
  onAuthStateChanged(AuthState state) {
    if(state == AuthState.LOGGED_IN)
      Navigator.push(context, ScaleRoute(page: HomePage(title: 'Home')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            _context = context;
            return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.green, Colors.yellow]
                  ),
                ),
                child: Center(
                  child: Wrap(
                      children: <Widget>[
                        Center(
                          child: Text('Halo POS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'CaroselloRegular'
                              ),
                              textAlign: TextAlign.center
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Card(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)
                              ),
                              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                              child: new Column(
                                children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                                      child: Text('Login',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 22,
                                            fontFamily: 'CaroselloRegular'
                                        ),
                                      )
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'BwSurcoBook'
                                      ),
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.perm_identity,
                                            color: Colors.grey,
                                            size: 26.0,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          fillColor: Colors.white,
                                          hintText: 'Username',
                                          contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                                      ),
                                      onSaved: (val) => _username = val,
                                      validator: (val) {
                                        return val.length < 10
                                            ? "Username must have atleast 10 chars"
                                            : null;
                                      },
                                    ),
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                                    child: TextFormField(
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'BwSurcoBook'
                                        ),
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock_outline,
                                              color: Colors.grey,
                                              size: 26.0,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            fillColor: Colors.white,
                                            hintText: 'Password',
                                            contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                                        ),
                                        obscureText: true,
                                        onSaved: (val) => _password = val
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0,right: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text('Lupa Password', style: TextStyle(
                                            color: Colors.blue,
                                            fontFamily: 'BwSurcoBook'
                                        ),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                                    child: _isLoading ? CircularProgressIndicator() : new RaisedButton(
                                      padding: const EdgeInsets.all(10.0),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.blue)
                                      ),
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      onPressed: () {
                                        doLogin();
                                      },
                                      child: new Text("Login"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Belum mempunyai Akun? ',
                                            style: TextStyle(
                                                fontFamily: 'BwSurcoBook'
                                            )
                                        ),
                                        new GestureDetector(
                                            onTap: () {
                                              Navigator.push(context, FadeRoute(page: RegistrationPage()));
                                            },
                                            child: Text('Daftar Sekarang',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontFamily: 'BwSurcoBook'
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image.asset('assets/images/ic_gmail.png', fit: BoxFit.fill, alignment: Alignment.center, width: 50),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image.asset('assets/images/ic_facebook.png', fit: BoxFit.fill, alignment: Alignment.center, width: 50),
                              ),
                            ],
                          ),
                        )
                      ]
                  ),
                )
            );
          },
        )
    );
  }

  @override
  void onLoginError(String msg) {
    createSnackBar(msg);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(ResponseAccount user) async {
    createSnackBar('Login berhasil!');
    setState(() => _isLoading = false);
    var db = new DatabaseHelper();
    await db.saveUser(user.value);

    Navigator.push(context, ScaleRoute(page: HomePage(title: 'Home')));
  }
}