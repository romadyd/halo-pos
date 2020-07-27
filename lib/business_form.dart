import 'dart:async';

import 'package:flutter/material.dart';
import 'package:halopos/components/loading_dialog.dart';
import 'package:halopos/models/area_model.dart';
import 'package:halopos/models/business_type_model.dart';
import 'package:halopos/models/selection_model.dart';
import 'package:halopos/presenters/business_form_presenter.dart';

import 'components/selection_dialog.dart';
import 'data/database_helper.dart';
import 'models/business_model.dart';
import 'models/response_model.dart';

class BusinessFormPage extends StatefulWidget {
  BusinessFormPage({Key key, this.title, this.entity}) : super(key: key);

  final String title;
  final Business entity;

  @override
  _BusinessFormPageState createState() => _BusinessFormPageState();
}

class _BusinessFormPageState extends State<BusinessFormPage>
    implements BusinessFormContract {
  BusinessFormPresenter _presenter;
  BuildContext _context;

  /* ==== Form ==== */
  LoadingDialog ld;
  final formKey = new GlobalKey<FormState>();
  String _id, _businessName, _businessType, _countryId, _provinceId, _cityId, _districtId, _villageOfficeId, _currency, _subscribe, _expired, _status, _createdAt, _createdBy, _updatedAt, _updatedBy;
  String _businessTypeText, _provinceText, _cityText, _districtText, _villageOfficeText;
  List<SelectionModel> _businessTypeList, _provinceList, _cityList, _districtList, _villageOfficeList;
  bool _vat;

  _BusinessFormPageState() {
    _presenter = BusinessFormPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    ld = new LoadingDialog(context);

    if (widget.entity.id != null) {
      setState(() {
        _id = widget.entity.id;
        _businessName = widget.entity.businessName;
        _businessType = widget.entity.businessType;
        _provinceId = widget.entity.provinceId;
        _cityId = widget.entity.cityId;
        _districtId = widget.entity.districtId;
        _villageOfficeId = widget.entity.villageOfficeId;
        _vat = widget.entity.vat;
      });
    }

    _businessTypeList = _provinceList = _cityList = _districtList = _villageOfficeList = new List();
    _businessTypeText = _provinceText = _cityText = _districtText = _villageOfficeText = "Pilih Satu";

    setupInit();
  }

  setupInit() {
    Timer(Duration(milliseconds: 500), () {
      _presenter.getBusinessTypeList();
      _presenter.getAreaByLevel(1);
    });
  }

  Widget FormBusiness() {
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
                      hintText: 'Nama Bisnis',
                      contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0)
                  ),
                  initialValue: _businessName != null ? _businessName : '',
                  onChanged: (val) => _businessName = val,
                  validator: (val) {
                    return val.length < 10 ? "Business Name must have atleast 3 chars" : null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: GestureDetector(
                    onTap: () {
                      selectionDialog(context,
                          title: 'Jenis Bisnis',
                          multiple: false,
                          callback: onSelectBusinessType,
                          adapter: _businessTypeList
                      ).show();
                    },
                    child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              child: Text(_businessTypeText,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'BwSurcoBook',
                                ),
                              ),
                            ),
                          ),
                          Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                              size: 26.0
                          )
                        ],
                      ),
                    )
                  )
                )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: GestureDetector(
                      onTap: () {
                        selectionDialog(context,
                            title: 'Provinsi',
                            multiple: false,
                            callback: onSelectProvince,
                            adapter: _provinceList
                        ).show();
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    child: Text(_provinceText,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'BwSurcoBook',
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                    size: 26.0
                                )
                              ],
                            ),
                          )
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: GestureDetector(
                      onTap: () {
                        selectionDialog(context,
                            title: 'Kota/Kabupaten',
                            multiple: false,
                            callback: onSelectCity,
                            adapter: _cityList
                        ).show();
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    child: Text(_cityText,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'BwSurcoBook',
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                    size: 26.0
                                )
                              ],
                            ),
                          )
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: GestureDetector(
                      onTap: () {
                        selectionDialog(context,
                            title: 'Kecamatan',
                            multiple: false,
                            callback: onSelectDistrict,
                            adapter: _districtList
                        ).show();
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    child: Text(_districtText,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'BwSurcoBook',
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                    size: 26.0
                                )
                              ],
                            ),
                          )
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: GestureDetector(
                      onTap: () {
                        selectionDialog(context,
                            title: 'Kelurahan',
                            multiple: false,
                            callback: onSelectVillageOffice,
                            adapter: _villageOfficeList
                        ).show();
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    child: Text(_villageOfficeText,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'BwSurcoBook',
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                    size: 26.0
                                )
                              ],
                            ),
                          )
                      )
                  )
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

  void onSelectBusinessType(SelectionModel i) {
    setState(() {
      _businessType = i.value;
      _businessTypeText = i.text;
    });
  }

  void onSelectProvince(SelectionModel i) {
    setState(() {
      _provinceId = i.value;
      _provinceText = i.text;

      _cityId = _districtId = _villageOfficeId = _cityText = _districtText = _villageOfficeText = "Pilih Satu";
      _presenter.getAreaByParentId(2, _provinceId);
    });

    _cityList = _districtList = _villageOfficeList = new List();
  }

  void onSelectCity(SelectionModel i) {
    setState(() {
      _cityId = i.value;
      _cityText = i.text;

      _districtId = _villageOfficeId = _districtText = _villageOfficeText = "Pilih Satu";
      _presenter.getAreaByParentId(3, _cityId);
    });

    _districtList = _villageOfficeList = new List();
  }

  void onSelectDistrict(SelectionModel i) {
    setState(() {
      _districtId = i.value;
      _districtText = i.text;

      _villageOfficeId = _villageOfficeText = "Pilih Satu";
      _presenter.getAreaByParentId(4, _districtId);
    });

    _villageOfficeList = new List();
  }

  void onSelectVillageOffice(SelectionModel i) {
    setState(() {
      _villageOfficeId = i.value;
      _villageOfficeText = i.text;
    });
  }

  void doCreate() {
    _presenter.createBusiness(Business(
        id: _id,
        businessName: _businessName,
        businessType: _businessType,
        countryId: _countryId,
        provinceId: _provinceId,
        cityId: _cityId,
        districtId: _districtId,
        villageOfficeId: _villageOfficeId,
        currency: _currency
    ));
  }

  void doUpdate() {
    _presenter.updateBusiness(Business(
        id: _id,
        businessName: _businessName,
        businessType: _businessType,
        countryId: _countryId,
        provinceId: _provinceId,
        cityId: _cityId,
        districtId: _districtId,
        villageOfficeId: _villageOfficeId,
        currency: _currency
    ));
  }

  void doDelete() {
    _presenter.deleteBusiness(Business(
        id: _id,
        businessName: _businessName,
        businessType: _businessType,
        countryId: _countryId,
        provinceId: _provinceId,
        cityId: _cityId,
        districtId: _districtId,
        villageOfficeId: _villageOfficeId,
        currency: _currency
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
                    FormBusiness()
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
  void onCreateSuccess(ResponseBusiness entities) {
    showMessage('Berhasil membuat business baru!');
    Navigator.pop(_context);
  }

  @override
  void onUpdateSuccess(ResponseBusiness entities) {
    showMessage('Berhasil mengupdate business!');
    Navigator.pop(_context);
  }

  @override
  void onDeleteSuccess(ResponseModel entity) {
    showMessage('Berhasil menghapus business!');
    Navigator.pop(_context);
  }

  @override
  void onGetAreaSuccess(int level, ResponseAreaList entities) {
    switch (level) {
      case 1:
        _provinceList = new List();
        for (Area entity in entities.value) {
          _provinceList.add(new SelectionModel(value: entity.id, text: entity.areaName));

          if (_provinceId == entity.id) {
            setState(() {
              _provinceText = entity.areaName;
            });
            _presenter.getAreaByParentId(2, _provinceId);
          }
        }
        break;
      case 2:
        _cityList = new List();
        for (Area entity in entities.value) {
          _cityList.add(new SelectionModel(value: entity.id, text: entity.areaName));

          if (_cityId == entity.id) {
            setState(() {
              _cityText = entity.areaName;
            });
            _presenter.getAreaByParentId(3, _cityId);
          }
        }
        break;
      case 3:
        _districtList = new List();
        for (Area entity in entities.value) {
          _districtList.add(new SelectionModel(value: entity.id, text: entity.areaName));

          if (_districtId == entity.id) {
            setState(() {
              _districtText = entity.areaName;
            });
            _presenter.getAreaByParentId(4, _districtId);
          }
        }
        break;
      case 4:
        _villageOfficeList = new List();
        for (Area entity in entities.value) {
          _villageOfficeList.add(new SelectionModel(value: entity.id, text: entity.areaName));

          if (_villageOfficeId == entity.id) {
            setState(() {
              _villageOfficeText = entity.areaName;
            });
          }
        }
        break;
    }
  }

  @override
  void onGetBusinessTypeSuccess(ResponseBusinessTypeList entities) {
    _businessTypeList = new List();
    for (BusinessType entity in entities.value) {
      _businessTypeList.add(new SelectionModel(value: entity.id, text: entity.businessType));

      if (_businessType == entity.id) {
        setState(() {
          _businessTypeText = entity.businessType;
        });
      }
    }
  }
}