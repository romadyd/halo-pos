/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class BusinessType {
  final String id;
  final String businessType;

  BusinessType ({this.id, this.businessType});

  @override
  String toString() {
    return 'BusinessType{id: $id, businessType: $businessType}';
  }

  factory BusinessType.map(dynamic json) {
    return BusinessType(
      id: json['ID'],
      businessType: json['BusinessType'],
    );
  }
}


/* Http Responses */
class ResponseBusinessTypeList {
  final bool status;
  final List<BusinessType> value;

  ResponseBusinessTypeList ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseBusinessTypeList.map(dynamic json) {
    return ResponseBusinessTypeList(
        status: json['Status'],
        value: List<BusinessType>.from(json['Value'].map((obj) {
          return BusinessType.map(obj);
        }))
    );
  }
}

class ResponseBusinessType {
  final bool status;
  final BusinessType value;

  ResponseBusinessType ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseBusinessType.map(dynamic json) {
    return ResponseBusinessType(
        status: json['Status'],
        value: BusinessType.map(json['Value'])
    );
  }
}
