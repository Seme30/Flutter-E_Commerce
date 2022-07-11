import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
   const RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 75,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(iconData: Icons.clear)),
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
                          child: AppIcon(iconData: Icons.circle, iconColor: Colors.transparent, size: 20, backgroundColor: AppColors.mainColor,)):
                        Container(),
                        popularProduct.totalItems>=1?
                        Positioned(
                          right: 3,
                          top: 3,
                          child: BigText(text: popularProduct.totalItems.toString(),
                          size: 12, color: Colors.white,)):
                        Container(),
                      ],
                    ),
                  );
                }),
              ]
              ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(top:5, bottom: 10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20)
                  )
                ),
                child: Center(child: BigText(text: product.name!, size: Dimensions.font26,)),
              ),),
            pinned: true,  
            expandedHeight: 300,
            backgroundColor: AppColors.yellowColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOADS_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(text:
                    product.description!
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.setQuantity(false);
                  },
                  child: AppIcon(iconData: Icons.remove, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24,)),
                BigText(text: "\$ ${product.price!}X ${controller.cartItems}", color: AppColors.mainColor,
                size: Dimensions.font26,),
                GestureDetector(
                  onTap: (){
                    controller.setQuantity(true);
                  },
                  child: AppIcon(iconData: Icons.add, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24)),
              ],
            ),
          ),
          Container(
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
              child:  Icon(Icons.favorite, color: AppColors.mainColor,),
            ),
            GestureDetector(
              onTap: (){
                  controller.addItem(product);
                },
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                  ),
                  child: BigText(text: "\$ ${product.price} | Add to Cart", color: Colors.white,),
              ),
            )
          ],
          ),
      ),
        ],
      );
      }
    ),);
  }
}