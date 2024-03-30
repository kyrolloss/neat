import 'package:flutter/material.dart';
import 'package:neat/User%20Screens/Screens/authentication/screens/onboarding/widgets/onboarding_page.dart';
import '../../../../../utlis/constants/image_strings.dart';
import '../../../../../utlis/constants/text_strings.dart';
import 'widgets/onboarding_next_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Stack(
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


