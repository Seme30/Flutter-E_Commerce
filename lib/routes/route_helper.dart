import 'package:e_commerce/screens/card/cart_screen.dart';
import 'package:e_commerce/screens/food/popular_food_detail.dart';
import 'package:e_commerce/screens/food/recommended_food_detail.dart';
import 'package:e_commerce/screens/home/HomeScreenMain.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartScreen = "/cart-screen";

  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId)=>'$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId)=>'$recommendedFood?pageId=$pageId';
  static String getCartScreen()=>'$cartScreen';

  static List<GetPage> routes = [
    
    GetPage(name: "/", page: ()=> HomeScreenMain()),

    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      return PopularFoodDetailScreen(pageId: int.parse(pageId!));
    }, transition: Transition.fadeIn
    ),
    
    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!),);
    }, transition: Transition.fadeIn
    ),

    GetPage(name: cartScreen, page: () {
      return CartScreen();
    },
    transition: Transition.fadeIn
    )
  ];
}