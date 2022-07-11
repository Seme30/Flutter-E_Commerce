
import 'package:e_commerce/models/Product.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;
  


  CartModel({
    this.id,
    this.name,
    this.img,
    this.price,
    this.isExist,
    this.quantity,
    this.time,
    this.product
  });

  CartModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    img = json['img'];
    time = json['time'];
    isExist = json['isExist'];
    product = ProductModel.fromJson(json['product']);
  }
}