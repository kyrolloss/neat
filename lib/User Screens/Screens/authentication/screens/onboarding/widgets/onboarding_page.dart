import 'package:flutter/material.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/image_strings.dart';
import 'package:neat/utlis/constants/text_strings.dart';

import '../../../../../../utlis/constants/sizes.dart';

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
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          const SizedBox(height: TSizes.xl * 4 ,),
          const Image(
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