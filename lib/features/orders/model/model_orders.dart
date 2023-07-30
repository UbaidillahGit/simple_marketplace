import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'model_orders.g.dart';

@HiveType(typeId: 3)
class ModelOrders extends HiveObject {
  @HiveField(0)
  List<Orders>? orders;

  @HiveField(1)
  int? totalPrice;

  @HiveField(2)
  int? totalItems;

  ModelOrders({this.orders, this.totalPrice, this.totalItems});

  ModelOrders.fromJson(Map<String, dynamic> json ){
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
    totalItems = json['totalItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((e) => e.toJson()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['totalItems'] = totalItems;

    return data;
  }

  @override
  int get hashCode => Object.hash(
        Object.hashAll(orders!),
        totalPrice,
        totalItems,
      );

  @override
  bool operator == (Object other) => 
  identical(this, other) ||
  other is ModelOrders &&
  listEquals(other.orders, orders) &&
  other.totalPrice == totalPrice &&
  other.totalItems == totalItems;
}

@HiveType(typeId: 4)
class Orders extends HiveObject {
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

  @HiveField(11)
  int? quantity;

  Orders(
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
      this.images, this.quantity});

  Orders.fromJson(Map<String, dynamic> json) {
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
    quantity = json['quantity'];
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
    data['quantity'] = quantity;
    return data;
  }
    
  @override
  int get hashCode => Object.hash(
    // runtimeType,
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
  bool operator == (Object other) =>
  identical(this, other) || 
  other is Orders &&
  // runtimeType == other.runtimeType &&
  other.id == id &&
  other.title == title &&
  other.description == description &&
  other.price == price &&
  other.discountPercentage == discountPercentage &&
  other.rating == rating &&
  other.stock == stock &&
  other.brand == brand &&
  other.category == category &&
  other.thumbnail == thumbnail &&
  listEquals(other.images, images);

  // @override
  // List<Object?> get props => [
  //       runtimeType,
  //       id,
  //       title,
  //       description,
  //       price,
  //       discountPercentage,
  //       rating,
  //       stock,
  //       brand,
  //       category,
  //       thumbnail,
  //       images,
  //     ];
      
        // @override
        // bool? get stringify => true;
}