import 'package:flutter/material.dart';
import 'package:halopos/business.dart';
import 'package:halopos/providers/auth_provider.dart';

import 'utils/transition.dart';
import 'home.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    implements AuthStateListener{

  final fullNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                  Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)
                      ),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                      child: new Column(
                        children: <Widget>[
                          new Padding(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                              child: Text('Registrasi',
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
                                  hintText: 'Nama Lengkap',
                                  contentPadding: EdgeInsets.only(left: 20.0, top: 0.0, bottom: 0.0, right: 20.0)
                              ),
                              controller: fullNameController,
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
                                    Icons.email,
                                    color: Colors.grey,
                                    size: 26.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  fillColor: Colors.white,
                                  hintText: 'E-mail',
                                  contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                              ),
                              controller: emailController,
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
                                    Icons.phone_android,
                                    color: Colors.grey,
                                    size: 26.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  fillColor: Colors.white,
                                  hintText: 'Nomor HP',
                                  contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                              ),
                              controller: mobileController,
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
                              controller: passwordController,
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
                                  hintText: 'Konfirmasi Password',
                                  contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                              ),
                              obscureText: true,
                              controller: passwordConfirmController,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                            child: new RaisedButton(
                              padding: const EdgeInsets.all(10.0),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.blue)
                              ),
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.pushReplacement(context, ScaleRoute(page: BusinessPage()));
                              },
                              child: new Text("Registrasi"),
                            ),
                          ),
                        ],
                      )
                  ),
                ]
            ),
          )
        )
    );
  }

  @override
  void onAuthStateChanged(AuthState state) {

  }
}