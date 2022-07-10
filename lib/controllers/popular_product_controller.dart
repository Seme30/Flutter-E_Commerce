import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/data/repo/popular_product_repo.dart';
import 'package:e_commerce/models/CartModel.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _cartItems = 0;
  int get cartItems => _cartItems;

  void setQuantity(bool isIncrement){
    if(isIncrement){
    _quantity = checkQuantity(_quantity + 1);
    }else{
     _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_cartItems+_quantity)<0){
      Get.snackbar("Item Count", "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white);
        if(_cartItems>0){
          _quantity = - _cartItems;
          return _quantity;
        }
        return 0;
    } else if((_cartItems+_quantity)>20){
        Get.snackbar("Item Count", "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white);
        return 20;
    }
    else{
      return quantity;
    } 
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _cartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if(exist){
      _cartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product){
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _cartItems = _cart.getQuantity(product);
      update();
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      print('got product');
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }

}