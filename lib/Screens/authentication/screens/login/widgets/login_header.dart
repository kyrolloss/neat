import 'package:flutter/material.dart';

import '../../../../../utlis/constants/image_strings.dart';
import '../../../../../utlis/constants/sizes.dart';
class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: TSizes.xl *4,),
        Image(

          image: AssetImage(TImages.loginImage),),

      ],
    );
  }
}