import 'package:flutter/material.dart';

Widget ImageInitial(String title, double width, double height, double fontSize) {
  var str = title.split(' ');
  var initial = (str[0].substring(0, 1) + (str.length > 1 ? str[str.length - 1].substring(0, 1) : str[0].substring(1, 2))).toUpperCase();

  return Stack(
    children: <Widget>[
      Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[
              Colors.lightBlueAccent,
              Colors.blue
            ],
          ),
        ),
        child: Text(
          initial,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    ],
  );
}