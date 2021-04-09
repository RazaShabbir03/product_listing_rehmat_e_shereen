// To parse this JSON data, do
//
//     final productListing = productListingFromJson(jsonString);

import 'dart:convert';

ProductListing productListingFromJson(String str) =>
    ProductListing.fromJson(json.decode(str));

String productListingToJson(ProductListing data) => json.encode(data.toJson());

class ProductListing {
  ProductListing({
    this.data,
    this.code,
    this.message,
    this.imageUrl,
  });

  List<Datum> data;
  int code;
  String message;
  String imageUrl;

  factory ProductListing.fromJson(Map<String, dynamic> json) => ProductListing(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        code: json["code"],
        message: json["message"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "message": message,
        "image_url": imageUrl,
      };
}

class Datum {
  Datum({
    this.id,
    this.unitId,
    this.code,
    this.name,
    this.featuredImage,
    this.price,
    this.weight,
    this.description,
    this.isFeatured,
    this.customizeBox,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.categoryProduct,
  });

  int id;
  int unitId;
  String code;
  String name;
  String featuredImage;
  String price;
  String weight;
  String description;
  int isFeatured;
  int customizeBox;
  int status;
  int createdBy;
  int updatedBy;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<CategoryProduct> categoryProduct;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        unitId: json["unit_id"] == null ? null : json["unit_id"],
        code: json["code"],
        name: json["name"],
        featuredImage:
            json["featured_image"] == null ? null : json["featured_image"],
        price: json["price"],
        weight: json["weight"] == null ? null : json["weight"],
        description: json["description"] == null ? null : json["description"],
        isFeatured: json["is_featured"],
        customizeBox: json["customize_box"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryProduct: List<CategoryProduct>.from(
            json["category_product"].map((x) => CategoryProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_id": unitId == null ? null : unitId,
        "code": code,
        "name": name,
        "featured_image": featuredImage == null ? null : featuredImage,
        "price": price,
        "weight": weight == null ? null : weight,
        "description": description == null ? null : description,
        "is_featured": isFeatured,
        "customize_box": customizeBox,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category_product":
            List<dynamic>.from(categoryProduct.map((x) => x.toJson())),
      };
}

class CategoryProduct {
  CategoryProduct({
    this.id,
    this.categoryId,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int categoryId;
  int productId;
  DateTime createdAt;
  DateTime updatedAt;

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      CategoryProduct(
        id: json["id"],
        categoryId: json["category_id"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
