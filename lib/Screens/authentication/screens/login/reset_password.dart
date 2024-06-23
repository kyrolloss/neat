import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';
class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(
                image:  const AssetImage('assets/images/user/deliveredEmailIllustration).png'),
                width: 220,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Title & Subtitle
              Text(
                'change Your Password Title',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Text(
              //   TText.changeYourPasswordSubTitle,
              //   style: Theme.of(context).textTheme.labelMedium,
              //   textAlign: TextAlign.center,
              // ),
              // const SizedBox(
              //   height: TSizes.spaceBtwSections,
              // ),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){},
                    child: const Text(TText.done)),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: (){},
                    child: const Text(TText.resendEmail)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
