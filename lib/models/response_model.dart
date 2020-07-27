/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class ResponseModel {
  final bool status;
  final int value;

  ResponseModel ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseModel.map(dynamic json) {
    return ResponseModel(
        status: json['Status'],
        value: json['Value']
    );
  }
}