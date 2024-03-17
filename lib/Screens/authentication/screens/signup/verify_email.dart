import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neat/Screens/authentication/screens/login/login_screen.dart';
import 'package:neat/common/widgets/success_screen/success_screen.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/text_strings.dart';

import '../../../../utlis/constants/image_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.backgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              const Image(
                image: AssetImage(TImages.deliveredEmailIllustration2),
                width: double.infinity,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Title & Subtitle
              Text(
                TText.confirmEmail,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: TColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                "support@coding.com",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.greyColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                TText.confirmEmailSubTitle,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: TColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primaryColor),
                    onPressed: () {
                      navigateTo(context, SuccessScreen(
                        image: TImages.staticSuccessIllustration,
                        title: TText.yourAccountCreatedTitle,
                        subTitle: TText.yourAccountCreatedSubTitle,
                        onPressed: () {
                          navigateTo(context, const LoginScreen());
                        },
                      ));
                    },
                    child: const Text(
                      TText.tContinue,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      TText.resendEmail,
                      style: TextStyle(color: TColors.greyColor),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
