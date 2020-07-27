import 'package:flutter/material.dart';

class LoadingDialog {
  final BuildContext context;

  LoadingDialog(this.context);

  void show() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
          return Center(
              child: Wrap(
                children: <Widget>[
                  Material(
                    type: MaterialType.transparency,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white
                      ),
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text("Loading ..."),
                            )
                          ]
                      ),
                    ),
                  )
                ],
              )
          );
        }
    );
  }

  void dismiss() {
    Navigator.pop(context);
  }
}