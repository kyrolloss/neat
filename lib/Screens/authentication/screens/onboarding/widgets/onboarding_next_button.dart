import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/authentication/screens/login/login_screen.dart';

import '../../../../../utlis/constants/colors.dart';
class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom:60,
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(60, 60),
            side: const BorderSide(color: Colors.transparent),
            shape: const CircleBorder(),
            backgroundColor: TColors.primaryColor,
          ),
          child: const Icon(
            Iconsax.arrow_right_3,
            color: TColors.secondaryColor,
          )),
    );
  }
}
