import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/MainLayout.dart';
import 'package:neat/Screens/authentication/screens/signup/signup_screen.dart';
import 'package:neat/components/components.dart';


import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(child: Padding(padding: const EdgeInsets.symmetric(
      vertical: TSizes.spaceBtwSections,
    ),
      child: Column(
        children: [

          /// Email
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
             enabledBorder:  OutlineInputBorder(
               borderRadius: BorderRadius.circular(40),
               borderSide: const BorderSide(color: Colors.transparent),
             ),

                prefixIcon:  const Icon(Iconsax.direct_right),
                prefixIconColor: TColors.primaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),

                labelText: TText.email,
                filled: true,
                fillColor: TColors.secondaryColor,

                labelStyle: const TextStyle(
                  color: TColors.primaryColor,

                )
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields,),
          
          /// -- Password
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
                prefixIcon:  const Icon(Iconsax.password_check),
                prefixIconColor: TColors.primaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                labelText: TText.password,
                filled: true,
                fillColor: TColors.secondaryColor,

                labelStyle: const TextStyle(
                  color: TColors.primaryColor,
                )
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          SizedBox(
            width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  backgroundColor: TColors.primaryColor,
                  side: const BorderSide(
                    color: Colors.transparent
                  ),
                ),
                  onPressed: (){
                  navigateTo(context, MainLayout());
                  },
                child: const Text("Log in",style: TextStyle(fontSize: 18,color: TColors.secondaryColor),),
              ),
          ),

          const SizedBox(height: TSizes.spaceBtwItems,),

          /// Don't have account , Create account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(

                children: [
                  /// Don't have an account
                  Text(TText.loginTitle,style: TextStyle(color: TColors.greyColor),),
                ],
              ),

              /// Create Account
              TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
              }, child: const Text(TText.createAccount,style: TextStyle(color: TColors.primaryColor),)),
            ],
          ),


        ],
      ),
    ));
  }
}