import 'package:e_commerce/data/repo/cart_repo.dart';
import 'package:e_commerce/models/CartModel.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{

  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity){
    var totalquantity = 0;
    if(_items.containsKey(product.id)){
      _items.update(product.id!, (value){
        totalquantity = value.quantity!+totalquantity;
        return CartModel(
           id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity!+quantity,
          isExist: true,
          time: DateTime.now().toIso8601String()
        );
      });
      if(totalquantity<=0){
        _items.remove(product.id);
      }
    } else if(quantity>0){
      _items.putIfAbsent(product.id!, () => CartModel(
      id: product.id,
      name: product.name,
      price: product.price,
      img: product.img,
      quantity: quantity,
      isExist: true,
      time: DateTime.now().toIso8601String()
    ));
    } else {
        Get.snackbar("Item Count", "You should at least add an item in the cart!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white); 
    }

  }
  
  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    else {
      return false;
    }
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id!)){
      _items.forEach((key, value) {
        if(key==product.id!){
          quantity = value.quantity!;
        }
      });
    }
    
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

}