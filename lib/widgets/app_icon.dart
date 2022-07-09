import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

 AppIcon({
  Key? key,
  required this.iconData,
  this.iconSize = 16,
  this.iconColor = const Color(0xff756d54),
  this.backgroundColor = const Color(0xfffcf4e4),
  this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}