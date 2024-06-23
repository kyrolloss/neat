import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
   ForgetPassword({super.key});

  Future<void> resetPassword(String email) {

    return FirebaseAuth.instance
        .sendPasswordResetEmail(email: email);
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Headings
            Text('forget Password Title',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text('Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link.',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            /// Text field
            TextFormField(
              controller:emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.black,width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(10, )),
                ),
                hintText: TText.email,
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
                labelText: TText.email,
                prefixIcon: Icon(Iconsax.direct_right)
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections ),

            /// Submit Button
            SizedBox(width: 300,child: ElevatedButton(onPressed: () async{
              await resetPassword(emailController.text);
            }, child: const Text('submit' , style: TextStyle(fontSize: 20,color: Colors.black),)))
          ],
        ),
      ),
    );
  }
}
