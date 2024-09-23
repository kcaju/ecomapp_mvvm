// To parse this JSON data, do
//
//     final productResModel = productResModelFromJson(jsonString);

import 'dart:convert';

List<ProductResModel> productResModelFromJson(String str) =>
    List<ProductResModel>.from(
        json.decode(str).map((x) => ProductResModel.fromJson(x)));

// String productResModelToJson(List<ProductResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductResModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductResModel.fromJson(Map<String, dynamic> json) =>
      ProductResModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      );
}

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );
}
