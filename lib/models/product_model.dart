/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class Product {
  final String id;
  final String uniqueId;
  final String businessId;
  final String categoryId;
  final String productName;
  final String productDescription;
  final String createdAt;
  final String createdBy;
  final String updatedAt;
  final String updatedBy;

  Product ({
    this.id,
    this.uniqueId,
    this.businessId,
    this.categoryId,
    this.productName,
    this.productDescription,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy
  });

  @override
  String toString() {
    return 'ProductName{id: $id, uniqueId: $uniqueId, businessId: $businessId, categoryId: $categoryId, productName: $productName, productDescription: $productDescription, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy}';
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null)
      map['ID'] = id;

    if (uniqueId != null)
      map['UniqueID'] = uniqueId;

    if (businessId != null)
      map['BusinessID'] = businessId;

    if (categoryId != null)
      map['CategoryID'] = categoryId;

    if (productName != null)
      map['ProductName'] = productName;

    if (productDescription != null)
      map['ProductDescription'] = productDescription;

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

  factory Product.map(dynamic json) {
    return Product(
        id: json['ID'],
        uniqueId: json['UniqueID'],
        businessId: json['BusinessID'],
        categoryId: json['CategoryID'],
        productName: json['ProductName'],
        productDescription: json['ProductDescription'],
        createdAt: json['CreatedAt'],
        createdBy: json['CreatedBy'],
        updatedAt: json['UpdatedAt'],
        updatedBy: json['UpdatedBy']
    );
  }
}


/* Http Responses */
class ResponseProductList {
  final bool status;
  final List<Product> value;

  ResponseProductList ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseProductList.map(dynamic json) {
    return ResponseProductList(
        status: json['Status'],
        value: List<Product>.from(json['Value'].map((obj) {
          return Product.map(obj);
        }))
    );
  }
}

class ResponseProduct {
  final bool status;
  final Product value;

  ResponseProduct ({ this.status, this.value });

  @override
  String toString() {
    return 'ResponseModel{status: $status, value: $value}';
  }

  factory ResponseProduct.map(dynamic json) {
    return ResponseProduct(
        status: json['Status'],
        value: Product.map(json['Value'])
    );
  }
}
