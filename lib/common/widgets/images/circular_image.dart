import 'package:flutter/material.dart';

import '../../../utlis/constants/sizes.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit= BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
     this.width =56,
     this.height = 56,
     this.padding = TSizes.sm,
    this.icon, this.radius,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final double? radius;
  final IconData? icon;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding:  EdgeInsets.all(padding),
      decoration: BoxDecoration(
        // if img background Color is null then switch it to light and dark mode  color design
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        fit: fit,
          image:  NetworkImage(image) ,
        color: overlayColor,
      ),
    );
  }
}
