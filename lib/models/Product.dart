import 'package:flutter/rendering.dart';

class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;

  late List<ProductModel> products;

  Product({
    required totalSize,
    required typeId,
    required offset,
    required products
  }){
    this._totalSize = totalSize;
    this._offset = offset;
    this._typeId = typeId;
    this.products = products;
  }

  Product.fromJson(Map<String, dynamic> json){
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];

    if(json['products'] != null){
      products = <ProductModel> [];
      json['products'].forEach((v){
        products.add(ProductModel.fromJson(v));
      });
    }

  }
  
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.createdAt,
    this.img,
    this.location,
    this.stars,
    this.typeId,
    this.updatedAt
  });

  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    typeId = json['typeId'];
  }
}