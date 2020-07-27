/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class Business {
  final String id;
  final String uniqueId;
  final String businessName;
  final String businessType;
  final String countryId;
  final String provinceId;
  final String cityId;
  final String districtId;
  final String villageOfficeId;
  final String currency;
  final bool vat;
  final String subscribe;
  final String expired;
  final String status;
  final String createdAt;
  final String createdBy;
  final String updatedAt;
  final String updatedBy;

  Business ({
    this.id,
    this.uniqueId,
    this.businessName,
    this.businessType,
    this.countryId,
    this.provinceId,
    this.cityId,
    this.districtId,
    this.villageOfficeId,
    this.currency,
    this.vat,
    this.subscribe,
    this.expired,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy
  });

  @override
  String toString() {
    return 'BusinessType{id: $id, uniqueId: $uniqueId businessName: $businessName, businessType: $businessType, countryId: $countryId, provinceId: $provinceId, cityId: $cityId, districtId: $districtId, villageOfficeId: $villageOfficeId, currency: $currency, vat: $vat, subscribe: $subscribe, expired: $expired, status: $status, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy}';
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null)
      map['ID'] = id;

    if (uniqueId != null)
      map['UniqueID'] = uniqueId;

    if (businessName != null)
      map['BusinessName'] = businessName;

    if (businessType != null)
      map['BusinessType'] = businessType;

    if (countryId != null)
      map['CountryID'] = countryId;

    if (provinceId != null)
      map['ProvinceID'] = provinceId;

    if (cityId != null)
      map['CityID'] = cityId;

    if (districtId != null)
      map['DistrictID'] = districtId;

    if (villageOfficeId != null)
      map['VillageOfficeID'] = villageOfficeId;

    if (currency != null)
      map['Currency'] = currency;

    if (vat != null)
      map['VAT'] = vat.toString();

    if (subscribe != null)
      map['Subscribe'] = subscribe;

    if (expired != null)
      map['Expired'] = expired;

    if (status != null)
      map['Status'] = status;

    if (createdAt != null)
      map['CreatedAt'] = createdAt;

    if (createdBy != null)
      map['CreatedBy'] = createdBy;

    if (updatedAt != null)
      map['UpdatedAt'] = updatedAt;

    if (updatedBy != null)
      map['UpdatedBy'] = updatedBy;

    return map;
  }

  factory Business.map(dynamic json) {
    return Business(
      id: json['ID'],
      uniqueId: json['UniqueID'],
      businessName: json['BusinessName'],
      businessType: json['BusinessType'],
      countryId: json['CountryID'],
      provinceId: json['ProvinceID'],
      cityId: json['CityID'],
      districtId: json['DistrictID'],
      villageOfficeId: json['VillageOfficeID'],
      currency: json['Currency'],
      vat: json['VAT'],
      subscribe: json['Subscribe'],
      expired: json['Expired'],
      status: json['Status'],
      createdAt: json['CreatedAt'],
      createdBy: json['CreatedBy'],
      updatedAt: json['UpdatedAt'],
      updatedBy: json['UpdatedBy']
    );
  }
}


/* Http Responses */
class ResponseBusinessList {
  final bool status;
  final List<Business> value;

  ResponseBusinessList ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseBusinessList.map(dynamic json) {
    return ResponseBusinessList(
        status: json['Status'],
        value: List<Business>.from(json['Value'].map((obj) {
          return Business.map(obj);
        }))
    );
  }
}

class ResponseBusiness {
  final bool status;
  final Business value;

  ResponseBusiness ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseBusiness.map(dynamic json) {
    return ResponseBusiness(
        status: json['Status'],
        value: Business.map(json['Value'])
    );
  }
}
