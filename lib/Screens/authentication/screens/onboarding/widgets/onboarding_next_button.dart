import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/authentication/screens/login/login_screen.dart';


import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Positioned(
      right: TSizes.defaultSpace,
        bottom: 60,
        child: ElevatedButton(

            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(60, 60),
              side: BorderSide(color: Colors.transparent),
              shape: CircleBorder(),
              backgroundColor: TColors.primaryColor,
            ),
            child: Icon(Iconsax.arrow_right_3,color: TColors.secondaryColor,)));
  }
}
