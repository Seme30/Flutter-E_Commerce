import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.width20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(iconData: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,),
                  SizedBox(width: Dimensions.width20*5,),
                   GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                     child: AppIcon(iconData: Icons.home_outlined,
                                     iconColor: Colors.white,
                                     backgroundColor: AppColors.mainColor,
                                     iconSize: Dimensions.iconSize24,),
                   ),
                   AppIcon(iconData: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,)
                ],
              ),
            ),
            Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                    itemCount: _cartList.length,
                    itemBuilder: (_,index){
                    return Container(
                      width: Dimensions.width20*5,
                      height: Dimensions.height20*5,
                      child: Row(
                        children: [
                          Container(
                            width: Dimensions.width20*5,
                            height: Dimensions.height20*5,
                            margin: EdgeInsets.only(bottom:Dimensions.height10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  AppConstants.BASE_URL+AppConstants.UPLOADS_URL+cartController.getItems[index].img!
                                )),
                              borderRadius: BorderRadius.circular(Dimensions.radius20)
                            ),
                          ),
                          SizedBox(width: Dimensions.width10,),
                          Expanded(
                            child: Container(
                              height: Dimensions.height20*5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(text: _cartList[index].name!, color: Colors.black54,),
                                  SmallText(text: "Spicy"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(text: "\$ ${_cartList[index].price}", color: Colors.redAccent,),
                                      Container(
                                        padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white, 
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              cartController.addItem(_cartList[index].product!, -1);
                                            },
                                            child: Icon(Icons.remove, color: AppColors.signColor,
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10/2,),
                                          BigText(text: _cartList[index].quantity.toString(),),
                                          SizedBox(width: Dimensions.width10/2,),
                                          GestureDetector(
                                            onTap: (){
                                              cartController.addItem(_cartList[index].product!, 1);
                                            },
                                            child: Icon(Icons.add, color: AppColors.signColor,)),
                                        ],
                                      )
                                    ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
                  },)
                ),
              )),
          ],
        ),
    );
  }
}