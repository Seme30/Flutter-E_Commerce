import 'package:e_commerce/data/repo/popular_product_repo.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity.isEqual(20)? Get.snackbar("Item Count", "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white) 
       : (_quantity = _quantity + 1);
    }else{
      _quantity.isEqual(0)? Get.snackbar("Item Count", "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white) 
         : (_quantity = _quantity - 1);
    }
    update();
  }

  void initProduct(){
    _quantity = 0;
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
}