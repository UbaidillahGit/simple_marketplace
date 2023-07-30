import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'model_products.g.dart';

class ModelProducts extends HiveObject {
  List<Products>? products;

  int? total;
  int? skip;
  int? limit;

  ModelProducts({this.products, this.total, this.skip, this.limit});

  ModelProducts.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}

@HiveType(typeId: 0)
class Products extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  int? price;

  @HiveField(4)
  double? discountPercentage;

  @HiveField(5)
  dynamic rating;

  @HiveField(6)
  int? stock;

  @HiveField(7)
  String? brand;

  @HiveField(8)
  String? category;

  @HiveField(9)
  String? thumbnail;

  @HiveField(10)
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['brand'] = brand;
    data['category'] = category;
    data['thumbnail'] = thumbnail;
    data['images'] = images;
    return data;
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        id,
        title,
        description,
        price,
        discountPercentage,
        rating,
        stock,
        brand,
        category,
        thumbnail,
        Object.hashAll(images!),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Products &&
          other.runtimeType == runtimeType &&
          other.id == id &&
          other.title == title &&
          other.price == price &&
          other.discountPercentage == discountPercentage &&
          other.rating == rating &&
          other.stock == stock &&
          other.brand == brand &&
          other.category == category &&
          other.thumbnail == thumbnail &&
          listEquals(other.images, images);
}
