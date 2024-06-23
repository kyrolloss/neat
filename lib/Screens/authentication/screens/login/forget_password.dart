import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utlis/constants/colors.dart';
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

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Iconsax.arrow_left),
        ),
        title:  Text('forget Password',

            style: TextStyle(color: TColors.primaryColor , fontWeight: FontWeight.bold),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Headings

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text('Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link.',

                style: TextStyle(fontSize: 17.5,color: TColors.primaryColor , fontWeight: FontWeight.bold) ),
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
              if(emailController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your email'),));
                return;
              }
              else{
                await resetPassword(emailController.text);

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset Link Sent to your email '),));
                emailController.clear();

                Navigator.pop(context);
              }


            }, child: const Text('submit' , style: TextStyle(fontSize: 20,color: Colors.black),)))
          ],
        ),
      ),
    );
  }
}
