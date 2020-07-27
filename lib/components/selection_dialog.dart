import 'package:flutter/material.dart';
import 'package:halopos/models/selection_model.dart';

class selectionDialog extends StatefulBuilder {
  final BuildContext context;
  final String title;
  final bool multiple;
  final void Function(SelectionModel) callback;
  final List<SelectionModel> adapter;
  String filter = "";

  selectionDialog(this.context, {this.adapter, this.callback, this.title, this.multiple});

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
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height - 80,
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      new Padding(
                        padding: EdgeInsets.all(0.0),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'BwSurcoBook'
                          ),
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.filter_list,
                                color: Colors.grey,
                                size: 26.0,
                              ),
                              fillColor: Colors.white,
                              hintText: 'Cari ...',
                              contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0)
                          ),
                          onChanged: (val) => filter = val,
                        ),
                      ),
                      Expanded(
//                    child: SizedBox(
                          child: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                child: ListView.separated(
                                  padding: EdgeInsets.only(top: 5.0),
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey,
                                  ),
                                  itemBuilder: (context, index) {
                                    return filter == null || filter == "" ?
                                    InkWell(
                                        splashColor: Colors.blue,
                                        hoverColor: Colors.blue,
                                        highlightColor: Colors.blue,
                                        focusColor: Colors.blue,
                                        onTap: () {
                                          callback(adapter[index]);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    new Padding(
                                                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                                                        child: Text(adapter[index].text,
                                                          style: TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 14,
                                                              fontFamily: 'BwSurcoBook'
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                        )
                                    ) : adapter.contains(filter) ? InkWell(
                                        splashColor: Colors.blue,
                                        hoverColor: Colors.blue,
                                        highlightColor: Colors.blue,
                                        focusColor: Colors.blue,
                                        onTap: () {
                                          callback(adapter[index]);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    new Padding(
                                                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                                                        child: Text(adapter[index].text,
                                                          style: TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 14,
                                                              fontFamily: 'BwSurcoBook'
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                        )
                                    ) : Container();
                                  },
                                  itemCount: adapter.length,
                                ),
                              )
                          )
//                    ),
                      ),
                      (multiple == false ? SizedBox(height: 5.0) : Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.red,
                                  )
                              ),
                            ),
                            SizedBox(
                                width: 10.0
                            ),
                            Expanded(
                              child: SizedBox(
                                child: RaisedButton(
                                  onPressed: () {
                                    callback(SelectionModel(value: 'OK', text: 'OK'));
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: const Color(0xFF1BC0C5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}