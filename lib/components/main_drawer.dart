import 'package:flutter/material.dart';
import 'package:halopos/business.dart';
import 'package:halopos/data/database_helper.dart';
import 'package:halopos/login.dart';
import 'package:halopos/models/account_model.dart';
import 'package:halopos/utils/transition.dart';

import '../home.dart';

class MainDrawer extends StatelessWidget {
  BuildContext _context;

  DatabaseHelper db;
  Account _userSession;

  MainDrawer() {
    db = new DatabaseHelper();
    db.getUserSession().then((obj) {
      _userSession = obj;
    });
  }

  Future<void> doLogout() async {
    var db = new DatabaseHelper();
    await db.deleteUsers();
    Navigator.pushReplacement(_context, FadeRoute(page: LoginPage()));
  }


  @override
  Widget build(BuildContext context) {
    _context = context;
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child:
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.asset('assets/images/ic_pos.png', fit: BoxFit.fill, alignment: Alignment.center, width: 100),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(_userSession.fullName,
              style: TextStyle(
                fontFamily: 'BwSurcoBook',
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text('Administrator',
                style: TextStyle(
                    fontFamily: 'BwSurcoLight',
                    fontSize: 13
                ),
                textAlign: TextAlign.center
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
            child: RaisedButton(
              padding: const EdgeInsets.all(10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)
              ),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () {
                doLogout();
              },
              child: Text("Keluar"),
            ),
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ],
          ),
          ListTile(
            title: Text('Point of Sale'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, FadeRoute(page: HomePage(title: 'Point of Sale')));
            },
          ),
          ListTile(
            title: Text('Aktivitas'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Inventori'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Shift'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Outlet'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, FadeRoute(page: BusinessPage(title: 'Outlet')));
            },
          ),
          ListTile(
            title: Text('Laporan'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Pengaturan'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      )
    );
  }
}