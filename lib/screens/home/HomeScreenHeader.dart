import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';

class HomeScreenHeader extends StatefulWidget {
  const HomeScreenHeader({Key? key}) : super(key: key);

  @override
  State<HomeScreenHeader> createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(bottom: Dimensions.height15, top: Dimensions.height15),
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: "Ethiopia", color: AppColors.mainColor,),
                        Row(
                          children: [
                            SmallText(text: "Arbaminch"),
                            Icon(Icons.arrow_drop_down)
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: Dimensions.height45,
                      width: Dimensions.height45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                         color: AppColors.mainColor,
                        ),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                      ),
                    ),
                  ]),
            ),
          );
  }
}