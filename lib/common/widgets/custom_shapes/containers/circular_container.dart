import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';

class TCircularContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin ;
  final bool showBorder;
  final Color borderColor;

  const TCircularContainer({
    super.key,
    this.width,
    this.height,
    this.radius =TSizes.cardRadiusLg,
    this.padding ,
    this.child,
    this.backgroundColor =  TColors.secondaryColor,
    this.margin,
    this.showBorder = false,
    this.borderColor = TColors.borderPrimary
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding:  padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color:backgroundColor,
        border: showBorder ? Border.all(color:   TColors.primaryColor ) : null,
      ),
      child: child,
    );
  }
}