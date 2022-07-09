import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/screens/food/popular_food_detail.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_column.dart';
import 'package:e_commerce/widgets/icon_and_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:get/get.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  var _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
         _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularController){
          return popularController.isLoaded? Container(
          // color: Colors.redAccent,
          height: Dimensions.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: popularController.popularProductList.length,
            itemBuilder: (context,position){
            return _buildHomeBody(position, popularController.popularProductList[position]);
          }),
        ): CircularProgressIndicator();
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularController){
          return DotsIndicator(
            dotsCount: popularController.popularProductList.isEmpty?1:popularController.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeColor: AppColors.mainColor,
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.height30),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: "Recommended",),
              SizedBox(width: Dimensions.width10,),
              Container(
                // margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                // margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              ),
              // List
            ],
          ),
        ),
        SizedBox(height: Dimensions.height10,),
        GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
          return recommendedProducts.isLoaded? ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recommendedProducts.recommendedProductList.length,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getRecommendedFood(index));
              },
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height20),
                child: Row(
                  children: [
                    //image section
                    Container(
                      width: Dimensions.listViewImgSize,
                      height: Dimensions.listViewImgSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white38,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOADS_URL+recommendedProducts.recommendedProductList[index].img!),
                        ), 
                      ),
                    ),
                    //text section
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.width10),
                        height: Dimensions.listViewtextContSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius20),
                            bottomRight: Radius.circular(Dimensions.radius20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: recommendedProducts.recommendedProductList[index].name!),
                              SizedBox(height: Dimensions.height10,),
                              SmallText(text: "With Chinese characterstics"),
                              SizedBox(height: Dimensions.height10,),
                              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 IconAndTextWidget(
                  icon: Icons.circle_sharp, 
                  text: "Normal", 
                  iconColor: AppColors.iconColor1,),
                  IconAndTextWidget(
                  icon: Icons.location_on, 
                  text: "1.7km", 
                  iconColor: AppColors.mainColor,),
                  IconAndTextWidget(
                  icon: Icons.access_time_rounded,
                  text: "32min", 
                  iconColor: AppColors.iconColor2,),
                  
              ],
                      )
                              
                            ]
                            ),
                        ),
                      ),
            
                    ),
                  ],
                ),
              ),
            );
        }): CircularProgressIndicator(color: AppColors.mainColor,);
      
        }),
        
      ],
    );
  }

  Widget _buildHomeBody(int index, ProductModel popularProduct){
     Matrix4 matrix = Matrix4.identity();
    
    if(index==_currentPageValue.floor()){
      var currScale = 1 - (_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    } else if(index == _currentPageValue.floor()+1){
        var currScale = _scaleFactor + (_currentPageValue-index + 1) * (1 - _scaleFactor);
        var currTrans = _height * (1-currScale)/2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      }else if(index == _currentPageValue.floor()-1){
        var currScale = 1 - (_currentPageValue-index)*(1-_scaleFactor);
        var currTrans = _height * (1-currScale)/2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      }else{
        var currScale = 0.8;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,_height*(1-_scaleFactor)/2,1);
      }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
            height: Dimensions.pageViewContainer,
            margin:  EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven? Colors.black54: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOADS_URL+popularProduct.img!),
              )
            ),
                  ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin:  EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white,
              boxShadow: [
              BoxShadow(
                color: Color(0xffe8e8e8),
                blurRadius: 5.0,
                offset: Offset(0,5),
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-5,0)
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(5,0),
              )
            ],
            ),
            child: Container(
              padding: EdgeInsets.only(top: Dimensions.height10, left: 15, right: 15),
              child: AppColumn(text: popularProduct.name!,)
            ),
          ),
        )
    
      ]),
    );
  }
}