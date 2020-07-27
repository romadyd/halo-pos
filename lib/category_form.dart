import 'dart:async';

import 'package:flutter/material.dart';
import 'package:halopos/components/loading_dialog.dart';
import 'package:halopos/models/area_model.dart';
import 'package:halopos/models/business_type_model.dart';
import 'package:halopos/models/selection_model.dart';
import 'package:halopos/presenters/business_form_presenter.dart';
import 'package:halopos/presenters/category_form_presenter.dart';

import 'components/selection_dialog.dart';
import 'data/database_helper.dart';
import 'models/business_model.dart';
import 'models/category_model.dart';
import 'models/response_model.dart';

class CategoryFormPage extends StatefulWidget {
  CategoryFormPage({Key key, this.title, this.entity}) : super(key: key);

  final String title;
  final Category entity;

  @override
  _CategoryFormPageState createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage>
    implements CategoryFormContract {
  CategoryFormPresenter _presenter;
  BuildContext _context;

  /* ==== Form ==== */
  LoadingDialog ld;
  final formKey = new GlobalKey<FormState>();
  String _id, _businessId, _categoryName, _categoryDescription, _createdAt, _createdBy, _updatedAt, _updatedBy;

  _CategoryFormPageState() {
    _presenter = CategoryFormPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    ld = new LoadingDialog(context);

    if (widget.entity.id != null) {
      setState(() {
        _id = widget.entity.id;
        _businessId = widget.entity.businessId;
        _categoryName = widget.entity.categoryName;
        _categoryDescription = widget.entity.categoryDescription;
      });
    } else {
      _businessId = widget.entity.businessId;
    }
  }

  Widget FormCategory() {
    return Form(
      key: formKey,
      child: Card(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)
          ),
          margin: EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: TextFormField(
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'BwSurcoBook'
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.business,
                        color: Colors.grey,
                        size: 26.0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      fillColor: Colors.white,
                      hintText: 'Nama Kategori',
                      contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                  ),
                  initialValue: _categoryName != null ? _categoryName : '',
                  onChanged: (val) => _categoryName = val,
                  validator: (val) {
                    return val.length < 10 ? "Category Name must have atleast 3 chars" : null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: TextFormField(
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'BwSurcoBook'
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.description,
                        color: Colors.grey,
                        size: 26.0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      fillColor: Colors.white,
                      hintText: 'Deskripsi',
                      contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                  ),
                  initialValue: _categoryDescription != null ? _categoryDescription : '',
                  onChanged: (val) => _categoryDescription = val,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                child: RaisedButton(
                  padding: const EdgeInsets.all(10.0),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue)
                  ),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    if (widget.entity.id != null) {
                      doUpdate();
                    } else {
                      doCreate();
                    }
                  },
                  child: new Text("Simpan"),
                ),
              ),
            ],
          )
      ),
    );
  }

  void doCreate() {
    _presenter.createCategory(Category(
        id: _id,
        businessId: _businessId,
        categoryName: _categoryName,
        categoryDescription: _categoryDescription,
    ));
  }

  void doUpdate() {
    _presenter.updateCategory(Category(
        id: _id,
        businessId: _businessId,
        categoryName: _categoryName,
        categoryDescription: _categoryDescription,
    ));
  }

  void doDelete() {
    _presenter.deleteCategory(Category(
        id: _id,
        businessId: _businessId,
        categoryName: _categoryName,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.lightBlue,
      body: Builder(
          builder: (BuildContext context) {
            _context = context;
            return ListView(
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    FormCategory()
                  ],
                )
              ],
            );
          }
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
  void showMessage(String msg) {
    final snackBar = new SnackBar(content: new Text(msg), backgroundColor: Colors.blue);
    Scaffold.of(_context).showSnackBar(snackBar);
  }

  @override
  void onCreateSuccess(ResponseCategory entities) {
    showMessage('Berhasil membuat kategori baru!');
    Navigator.pop(_context);
  }

  @override
  void onUpdateSuccess(ResponseCategory entities) {
    showMessage('Berhasil mengupdate kategori!');
    Navigator.pop(_context);
  }

  @override
  void onDeleteSuccess(ResponseModel entity) {
    showMessage('Berhasil menghapus kategori!');
    Navigator.pop(_context);
  }
}