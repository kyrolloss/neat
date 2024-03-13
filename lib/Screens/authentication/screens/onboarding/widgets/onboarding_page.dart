import 'package:flutter/material.dart';

import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/image_strings.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
  });

  final String image, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          SizedBox(height: TSizes.xl * 4 ,),
          Image(
            image: AssetImage(TImages.onboardingImage),
          ),
          Text(
            TText.onBoardingTitle1,
            style: Theme.of(context).textTheme.headlineLarge!.apply(color: TColors.primaryColor),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}