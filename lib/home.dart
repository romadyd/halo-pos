import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:halopos/components/main_drawer.dart';
import 'package:halopos/presenters/home_presenter.dart';
import 'package:halopos/product.dart';
import 'package:halopos/utils/transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'category_form.dart';
import 'components/image_initial.dart';
import 'components/loading_dialog.dart';
import 'data/database_helper.dart';
import 'models/category_model.dart';
import 'models/config_model.dart';
import 'models/response_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>
    with WidgetsBindingObserver implements HomeContract {

  BuildContext _context;
  HomePresenter _presenter;
  DatabaseHelper db;
  Config _config;
  List<Category> _categoryList;

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  LoadingDialog ld;

  _HomePageState() {
    _categoryList = <Category>[];
    _presenter = HomePresenter(this);
    db = DatabaseHelper();
  }

  var _tapPosition;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ld = new LoadingDialog(context);

    setupInit();
  }

  void setupInit() {
    db.getConfig().then((config) {
      _config = config;
      _presenter.getAllCategory(Category(businessId: _config.currentBusinessId));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      _presenter.getAllCategory(Category(businessId: _config.currentBusinessId));
    }else if(state == AppLifecycleState.inactive){
      // app is inactive
    }else if(state == AppLifecycleState.paused){
      // user is about quit our app temporally
    }
  }

  void businessPopupMenu(Category entity) {
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
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white
                          ),
                          width: MediaQuery.of(context).size.width - 50,
                          padding: EdgeInsets.all(0.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                  focusColor: Colors.blue,
                                  hoverColor: Colors.blueAccent,
                                  splashColor: Colors.lightBlueAccent.withAlpha(40),
                                  highlightColor: Colors.lightBlueAccent.withAlpha(40),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(context, FadeRoute(page: CategoryFormPage(title: 'Edit Kategori', entity: entity)));
                                  },
                                  child: Container(
                                      width: double.maxFinite,
                                      child: Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text('Edit',
                                              style: TextStyle(
                                                fontFamily: 'BwSurcoBook',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                              ),
                                            )
                                        ),
                                      )
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                  focusColor: Colors.blue,
                                  hoverColor: Colors.blueAccent,
                                  splashColor: Colors.lightBlueAccent.withAlpha(40),
                                  highlightColor: Colors.lightBlueAccent.withAlpha(40),
                                  onTap: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Konfrimasi Hapus"),
                                          content: Text("Apakah anda yakin ingin menghapus ini?"),
                                          actions: [
                                            FlatButton(
                                                child: Text("Tidak"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }
                                            ),
                                            RaisedButton(
                                              child: Text("Ya"),
                                              color: Colors.blue,
                                              textColor: Colors.white,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _presenter.deleteCategory(entity);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      width: double.maxFinite,
                                      child: Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text('Delete',
                                              style: TextStyle(
                                                fontFamily: 'BwSurcoBook',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                              ),
                                            )
                                        ),
                                      )
                                  ),
                                ),
                              ]
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        );
      },
    );
  }

  Widget ListCategory(List<Category> entities) {
    return (entities.length > 0 ?
    ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.all(3.5),
            child: Material(
              type: MaterialType.canvas,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0)
                  )
              ),
              child: InkWell(
                focusColor: Colors.blue,
                hoverColor: Colors.blueAccent,
                splashColor: Colors.lightBlueAccent.withAlpha(40),
                highlightColor: Colors.lightBlueAccent.withAlpha(40),
                onTap: () {
                  Navigator.push(context, FadeRoute(page: ProductPage(title: 'Produk', categoryId: entities[index].id)));
                },
                onLongPress: () {
                  businessPopupMenu(entities[index]);
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: Colors.blue
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ImageInitial(entities[index].categoryName, 40.0, 40.0, 16.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(entities[index].categoryName,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontFamily: 'BwSurcoBook'
                                  ),
                                )
                            ),
                          ],
                        )
                      ],
                    )
                ),
              ),
            )
        );
      },
      itemCount: entities.length,
    ): Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.info_outline,
          color: Colors.grey,
          size: 40.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('Belum ada Kategori, silahkan tambahkan kategori item terlebih dahulu!',
            style: TextStyle(
              fontFamily: 'BwSurcoBook',
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MainDrawer(),
      body: Builder(
          builder: (BuildContext context) {
            _context = context;
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                child: ListCategory(_categoryList),
                footer: ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                  completeDuration: Duration(milliseconds: 500),
                ),
                header: WaterDropHeader(
                  waterDropColor: Colors.lightBlueAccent,
                ),
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  _presenter.getAllCategory(Category(businessId: _config.currentBusinessId));
                },
                onLoading: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  _presenter.getAllCategory(Category(businessId: _config.currentBusinessId));
                },
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, FadeRoute(page: CategoryFormPage(title: 'Kategori Baru', entity: Category(businessId: _config.currentBusinessId))));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void showLoading() {
    ld.show();
  }

  @override
  void hideLoading() {
    ld.dismiss();
  }

  @override
  void onDeleteSuccess(ResponseModel entity) {
    showMessage('Berhasil menghapus Kategori!');
    _presenter.getAllCategory(Category(businessId: _config.currentBusinessId));
  }

  @override
  void showMessage(String msg) {
    final snackBar = new SnackBar(content: new Text(msg), backgroundColor: Colors.blue, duration: Duration(milliseconds: 3000));
    Scaffold.of(_context).showSnackBar(snackBar);
  }

  @override
  void onGetCategorySuccess(ResponseCategoryList entities) {
    setState(() {
      _categoryList = entities.value;
    });

    _refreshController.refreshCompleted();
  }
}