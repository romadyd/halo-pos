/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class Area {
  final String id;
  final String areaCode;
  final String parentAreaCode;
  final String areaName;
  final int level;
  final String createdAt;
  final String updatedAt;

  Area ({
    this.id,
    this.areaCode,
    this.parentAreaCode,
    this.areaName,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Area{id: $id, areaCode: $areaCode, parentAreaCode: $parentAreaCode, areaName: $areaName, level: $level, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  factory Area.map(dynamic json) {
    return Area(
      id: json['ID'],
      areaCode: json['AreaCode'],
      parentAreaCode: json['ParentAreaCode'],
      areaName: json['AreaName'],
      level: json['Level'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
    );
  }
}


/* Http Responses */
class ResponseAreaList {
  final bool status;
  final List<Area> value;

  ResponseAreaList ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseAreaList.map(dynamic json) {
    return ResponseAreaList(
        status: json['Status'],
        value: List<Area>.from(json['Value'].map((obj) {
          return Area.map(obj);
        }))
    );
  }
}

class ResponseArea {
  final bool status;
  final Area value;

  ResponseArea ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseArea.map(dynamic json) {
    return ResponseArea(
        status: json['Status'],
        value: Area.map(json['Value'])
    );
  }
}
