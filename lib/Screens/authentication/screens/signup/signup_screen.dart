import 'package:flutter/material.dart';
import 'package:neat/Screens/authentication/screens/signup/widgets/signup_form.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  TText.signupTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.primaryColor),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                /// Form
                SignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


