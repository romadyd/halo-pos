/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class Category {
  final String id;
  final String uniqueId;
  final String businessId;
  final String categoryName;
  final String categoryDescription;
  final String createdAt;
  final String createdBy;
  final String updatedAt;
  final String updatedBy;

  Category ({
    this.id,
    this.uniqueId,
    this.businessId,
    this.categoryName,
    this.categoryDescription,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy
  });

  @override
  String toString() {
    return 'CategoryName{id: $id, uniqueId: $uniqueId, businessId: $businessId, categoryName: $categoryName, categoryDescription: $categoryDescription, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy}';
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null)
      map['ID'] = id;

    if (uniqueId != null)
      map['UniqueID'] = uniqueId;

    if (businessId != null)
      map['BusinessID'] = businessId;

    if (categoryName != null)
      map['CategoryName'] = categoryName;

    if (categoryDescription != null)
      map['CategoryDescription'] = categoryDescription;

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

  factory Category.map(dynamic json) {
    return Category(
        id: json['ID'],
        uniqueId: json['UniqueID'],
        businessId: json['BusinessID'],
        categoryName: json['CategoryName'],
        categoryDescription: json['CategoryDescription'],
        createdAt: json['CreatedAt'],
        createdBy: json['CreatedBy'],
        updatedAt: json['UpdatedAt'],
        updatedBy: json['UpdatedBy']
    );
  }
}


/* Http Responses */
class ResponseCategoryList {
  final bool status;
  final List<Category> value;

  ResponseCategoryList ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseCategoryList.map(dynamic json) {
    return ResponseCategoryList(
        status: json['Status'],
        value: List<Category>.from(json['Value'].map((obj) {
          return Category.map(obj);
        }))
    );
  }
}

class ResponseCategory {
  final bool status;
  final Category value;

  ResponseCategory ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseCategory.map(dynamic json) {
    return ResponseCategory(
        status: json['Status'],
        value: Category.map(json['Value'])
    );
  }
}
