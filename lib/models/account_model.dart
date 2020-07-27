/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class Account {
  final String id;
  final String googleId;
  final String facebookId;
  final String uniqueId;
  final String fullName;
  final String email;
  final String dateOfBirth;
  final String phone;
  final String mobile;
  final String identityType;
  final String identityNumber;
  final String address;
  final String photo;
  final String token;
  final String firebaseToken;
  final String mobileStatus;
  final String emailStatus;
  final String status;
  final String createdAt;
  final String createdBy;
  final String updatedAt;
  final String updatedBy;

  Account ({this.id, this.googleId, this.facebookId, this.uniqueId, this.fullName, this.email, this.dateOfBirth, this.phone, this.mobile, this.identityType, this.identityNumber, this.address, this.photo, this.token, this.firebaseToken, this.mobileStatus, this.emailStatus, this.status, this.createdAt, this.createdBy, this.updatedAt, this.updatedBy});

  @override
  String toString() {
    return 'Account{id: $id, googleId: $googleId, facebookId: $facebookId, uniqueId $uniqueId, fullName: $fullName, email: $email, dateOfBirth $dateOfBirth, phone: $phone, mobile: $mobile, identityType: $identityType, identityNumber: $identityNumber, address: $address, photo: $photo, token: $token, firebaseToken: $firebaseToken, mobileStatus: $mobileStatus, emailStatus: $emailStatus, status: $status, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy}';
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['ID'] = id;
    map['GoogleID'] = googleId;
    map['FacebookID'] = facebookId;
    map['UniqueID'] = uniqueId;
    map['FullName'] = fullName;
    map['Email'] = email;
    map['DateOfBirth'] = dateOfBirth;
    map['Phone'] = phone;
    map['Mobile'] = mobile;
    map['IdentityType'] = identityType;
    map['IdentityNumber'] = identityNumber;
    map['Address'] = address;
    map['Photo'] = photo;
    map['Token'] = token;
    map['FirebaseToken'] = firebaseToken;
    map['MobileStatus'] = mobileStatus;
    map['EmailStatus'] = emailStatus;
    map['Status'] = status;
    map['CreatedAt'] = createdAt;
    map['CreatedBy'] = createdBy;
    map['UpdatedAt'] = updatedAt;
    map['UpdatedBy'] = updatedBy;

    return map;
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        id: json['ID'],
        googleId: json['GoogleID'],
        facebookId: json['FacebookID'],
        uniqueId: json['UniqueID'],
        fullName: json['FullName'],
        email: json['Email'],
        dateOfBirth: json['DateOfBirth'],
        phone: json['Phone'],
        mobile: json['Mobile'],
        identityType: json['IdentityType'],
        identityNumber: json['IdentityNumber'],
        address: json['Address'],
        photo: json['Photo'],
        token: json['Token'],
        firebaseToken: json['TirebaseToken'],
        mobileStatus: json['MobileStatus'],
        emailStatus: json['EmailStatus'],
        status: json['Status'],
        createdAt: json['CreatedAt'],
        createdBy: json['CreatedBy'],
        updatedAt: json['UpdatedAt'],
        updatedBy: json['UpdatedBy']
    );
  }

  factory Account.map(dynamic obj) {
    return Account(
        id: obj['ID'],
        googleId: obj['GoogleID'],
        facebookId: obj['FacebookID'],
        uniqueId: obj['UniqueID'],
        fullName: obj['FullName'],
        email: obj['Email'],
        dateOfBirth: obj['DateOfBirth'],
        phone: obj['Phone'],
        mobile: obj['Mobile'],
        identityType: obj['IdentityType'],
        identityNumber: obj['IdentityNumber'],
        address: obj['Address'],
        photo: obj['Photo'],
        token: obj['Token'],
        firebaseToken: obj['FirebaseToken'],
        mobileStatus: obj['MobileStatus'],
        emailStatus: obj['MmailStatus'],
        status: obj['Status'],
        createdAt: obj['CreatedAt'],
        createdBy: obj['CreatedBy'],
        updatedAt: obj['UpdatedAt'],
        updatedBy: obj['UpdatedBy']
    );
  }
}


/* Http Responses */
class ResponseAccountList {
  final bool status;
  final List<Account> value;

  ResponseAccountList ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseAccountList.fromJson(Map<String, dynamic> json) {
    return ResponseAccountList(
        status: json['Status'],
        value: List<Account>.from(json['Value'].map((obj) {
          return Account.fromJson(obj);
        }))
    );
  }
}

class ResponseAccount {
  final bool status;
  final Account value;

  ResponseAccount ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseAccount.fromJson(Map<String, dynamic> json) {
    return ResponseAccount(
        status: json['Status'],
        value: (json['Value'] != null ? Account.fromJson(json['Value']) : null)
    );
  }
}


/* Http Request */
//class AccountRequest {
//  static Future<ResponseAccount> login(String uid, String pwd) async {
//    final response = await http.post('http://apihp.milogica.com/user/login', body: {
//      'mobile': uid,
//      'password': pwd
//    });
//
//    if (response.statusCode == 200) {
//      return ResponseAccount.fromJson(json.decode(response.body));
//    } else {
//      throw Exception('Failed to load album');
//    }
//  }
//
//}
