import 'package:flutter/material.dart';
import 'package:neat/utlis/constants/sizes.dart';

import '../../../../../../utlis/constants/image_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: TSizes.xl *4,),
        Image(

          image: AssetImage(TImages.loginImage),),

      ],
    );
  }
}