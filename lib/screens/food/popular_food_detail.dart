import 'dart:html';

import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/screens/home/HomeScreenMain.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_column.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:e_commerce/widgets/icon_and_text_widget.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetailScreen extends StatelessWidget {
  int pageId;
 PopularFoodDetailScreen({Key? key,required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: Dimensions.popularFoodImgSize,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOADS_URL+product.img!
                  ),
                ),
                ),
            ) 
          ),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(iconData: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(builder: (popularProduct){
                  return GestureDetector(
                    onTap: (){
                      if(popularProduct.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartScreen());
                    },
                    child: Stack(
                      children: [
                        AppIcon(iconData: Icons.shopping_cart_outlined),
                        popularProduct.totalItems>=1?
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getCartScreen());
                            },
                            child: AppIcon(iconData: Icons.circle, iconColor: Colors.transparent, size: 20, backgroundColor: AppColors.mainColor,))):
                        Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 3,
                          top: 3,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size: 12, color: Colors.white,)):
                        Container(),
                      ],
                    ),
                  );
                }),
              ],
            ), 
            ),
          //intro of foods
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - Dimensions.height20,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius30),
                  topLeft: Radius.circular(Dimensions.radius30),
                ), 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height20,),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: product.description!)))
                ],
              )
            ),
          ),  

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 *2),
              topRight: Radius.circular(Dimensions.radius20 *2),
            ),
            color: AppColors.buttonBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white, 
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.cartItems.toString(),),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(Icons.add, color: AppColors.signColor,)),
                  ],
                )
              ),
              GestureDetector(
                onTap: (){
                    popularProduct.addItem(product);
                  },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "\$ ${product.price!} | Add to Cart", 
                      color: Colors.white,
                      ),
                ),
              )
            ],
            ),
        );
      }
      ),
    );
  }
}