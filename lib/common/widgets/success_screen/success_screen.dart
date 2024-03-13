import 'package:flutter/material.dart';
import 'package:neat/common/styles/spacing_styles.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/text_strings.dart';

import '../../../utlis/constants/sizes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              /// Image
              Image(
                image: AssetImage(image),
                width: double.infinity*0.6,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Title & Subtitle
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: TColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Buttons
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primaryColor,
                      side: BorderSide(
                        color: Colors.transparent,
                      )),
                  onPressed: onPressed,
                  child: Text(
                    TText.tContinue,
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
