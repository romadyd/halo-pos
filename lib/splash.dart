import 'dart:async';
import 'package:flutter/material.dart';
import 'package:halopos/data/database_helper.dart';
import 'package:halopos/home.dart';
import 'package:halopos/login.dart';
import 'package:halopos/providers/auth_provider.dart';
import 'package:halopos/utils/transition.dart';

import 'business.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    implements AuthStateListener{
  Timer timer;

  @override
  void initState() {
    setupInit();
    super.initState();
  }

  void setupInit() async {
    timer = Timer.periodic(Duration(milliseconds: 1500), (_) {
      var authStateProvider = new AuthStateProvider();
      authStateProvider.subscribe(this);
    });
  }

  @override
  onAuthStateChanged(AuthState state) {
    if(state == AuthState.LOGGED_IN)
      doValidateSession();
    else
      Navigator.pushReplacement(context, SizeRoute(page: LoginPage()));
  }

  void doValidateSession() async {
    DatabaseHelper db = DatabaseHelper();
    db.isConfigured().then((config) {
      if (config) {
        Navigator.pushReplacement(context, SizeRoute(page: HomePage(title: 'Point of Sale',)));
      } else {
        Navigator.pushReplacement(context, SizeRoute(page: BusinessPage(title: 'Outlet')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.yellow]
            ),
          ),
        child: Center(
          child: Image.asset('assets/images/ic_pos.png'),
        ),
      )
    );
  }
}