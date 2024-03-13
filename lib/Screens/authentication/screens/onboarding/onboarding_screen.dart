import 'package:flutter/material.dart';
import 'package:neat/Screens/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:neat/Screens/authentication/screens/onboarding/widgets/onboarding_page.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: Stack(
        children: [
          /// Image & title
          OnBoardingPage(image: TImages.onboardingImage, title: TText.onBoardingTitle1,),

          /// Circular next button
          OnboardingNextButton(),
        ],
      ),
    );
  }
}


