/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class Config {
  final String id;
  final String currentBusinessId;
  final String currentBusiness;

  Config ({this.id, this.currentBusinessId, this.currentBusiness});

  @override
  String toString() {
    return 'Config{id: $id, currentBusinessId: $currentBusinessId, currentBusiness: $currentBusiness}';
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['ID'] = id;
    map['CurrentBusinessID'] = currentBusinessId;
    map['CurrentBusiness'] = currentBusiness;

    return map;
  }

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
        id: json['ID'],
        currentBusinessId: json['CurrentBusinessID'],
        currentBusiness: json['CurrentBusiness']
    );
  }

  factory Config.map(dynamic obj) {
    return Config(
        id: obj['ID'],
        currentBusinessId: obj['CurrentBusinessID'],
        currentBusiness: obj['CurrentBusiness']
    );
  }
}


/* Http Responses */
class ResponseConfigList {
  final bool status;
  final List<Config> value;

  ResponseConfigList ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseConfigList.fromJson(Map<String, dynamic> json) {
    return ResponseConfigList(
        status: json['Status'],
        value: List<Config>.from(json['Value'].map((obj) {
          return Config.fromJson(obj);
        }))
    );
  }
}

class ResponseConfig {
  final bool status;
  final Config value;

  ResponseConfig ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseConfig.fromJson(Map<String, dynamic> json) {
    return ResponseConfig(
        status: json['Status'],
        value: (json['Value'] != null ? Config.fromJson(json['Value']) : null)
    );
  }
}
