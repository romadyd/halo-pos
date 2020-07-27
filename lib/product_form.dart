import 'dart:async';

import 'package:flutter/material.dart';
import 'package:halopos/components/loading_dialog.dart';
import 'package:halopos/models/product_model.dart';
import 'package:halopos/presenters/product_form_presenter.dart';

import 'models/category_model.dart';
import 'models/response_model.dart';

class ProductFormPage extends StatefulWidget {
  ProductFormPage({Key key, this.title, this.entity}) : super(key: key);

  final String title;
  final Product entity;

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage>
    implements ProductFormContract {
  ProductFormPresenter _presenter;
  BuildContext _context;

  /* ==== Form ==== */
  LoadingDialog ld;
  final formKey = new GlobalKey<FormState>();
  String _id, _businessId, _categoryId, _productName, _productDescription, _createdAt, _createdBy, _updatedAt, _updatedBy;

  _ProductFormPageState() {
    _presenter = ProductFormPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    ld = new LoadingDialog(context);

    if (widget.entity.id != null) {
      setState(() {
        _id = widget.entity.id;
        _categoryId = widget.entity.categoryId;
        _businessId = widget.entity.businessId;
        _productName = widget.entity.productName;
        _productDescription = widget.entity.productDescription;
      });
    } else {
      _businessId = widget.entity.businessId;
      _categoryId = widget.entity.categoryId;
    }
  }

  Widget FormProduct() {
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
                      hintText: 'Nama Produk',
                      contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                  ),
                  initialValue: _productName != null ? _productName : '',
                  onChanged: (val) => _productName = val,
                  validator: (val) {
                    return val.length < 10 ? "Product Name must have atleast 3 chars" : null;
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
                  initialValue: _productDescription != null ? _productDescription : '',
                  onChanged: (val) => _productDescription = val,
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
    _presenter.createProduct(Product(
      id: _id,
      businessId: _businessId,
      categoryId: _categoryId,
      productName: _productName,
      productDescription: _productDescription,
    ));
  }

  void doUpdate() {
    _presenter.updateProduct(Product(
      id: _id,
      businessId: _businessId,
      categoryId: _categoryId,
      productName: _productName,
      productDescription: _productDescription,
    ));
  }

  void doDelete() {
    _presenter.deleteProduct(Product(
      id: _id,
      businessId: _businessId,
      categoryId: _categoryId,
      productName: _productName,
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
                    FormProduct()
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
  void onCreateSuccess(ResponseProduct entities) {
    showMessage('Berhasil membuat produk baru!');
    Navigator.pop(_context);
  }

  @override
  void onUpdateSuccess(ResponseProduct entities) {
    showMessage('Berhasil mengupdate produk!');
    Navigator.pop(_context);
  }

  @override
  void onDeleteSuccess(ResponseModel entity) {
    showMessage('Berhasil menghapus produk!');
    Navigator.pop(_context);
  }
}