import 'package:flutter/material.dart';
import 'package:neat/Screens/authentication/screens/signup/widgets/signup_form.dart';
import 'package:provider/provider.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';
import '../../../../utlis/constants/themes/theme_provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                      .apply(color:isDarkMode? TColors.secondaryColor : TColors.primaryColor),
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


