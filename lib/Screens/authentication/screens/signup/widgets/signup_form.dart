import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/MainLayout.dart';
import 'package:neat/Screens/authentication/screens/signup/verify_email.dart';
import 'package:neat/Screens/authentication/screens/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:neat/components/components.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';
import '../../../../chat/services/auth_services.dart';

class SignupForm extends StatefulWidget {
  SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  /// text controllers

  TextEditingController firstName = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController titleController = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController phone = TextEditingController();


  /// sign up user
  void signUp (BuildContext context){
    /// get auth service
    final authService = AuthService();

    /// If password Match -> create user
    if(password.text == confirmPassword.text){
      try{
        authService.signUpWithEmailandPassword(
            email.text,
            password.text
        );
      } catch (e){
        showDialog(
          context: context,
          builder: (context)=> AlertDialog(
            title: Text("Error", style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    /// Password doesn't match -> tell error to fix
    else{
      showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Text("Password doesn't match", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  // void signUp() async {
  //   if (password.text != confirmPassword.text) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Password doesn't match"),
  //       ),
  //     );
  //     return;
  //   }
  //
  //   /// get auth service
  //   final authService = Provider.of<AuthService>(context, listen: false);
  //   try {
  //     await authService.signUpWithEmailandPassword(email.text, password.text);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Form(
            child: Column(
          children: [
            Row(
              children: [
                /// First name
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: firstName,
                    expands: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: TColors.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: TColors.secondaryColor),
                      ),
                      labelText: TText.firstName,
                      labelStyle: const TextStyle(color: TColors.primaryColor),
                      prefixIcon: const Icon(Iconsax.user),
                      prefixIconColor: TColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),

                /// Last name
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: lastName,
                    expands: false,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: TColors.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: TColors.secondaryColor),
                        ),
                        labelText: TText.lastName,
                        labelStyle:
                            const TextStyle(color: TColors.primaryColor),
                        prefixIcon: const Icon(Iconsax.user),
                        prefixIconColor: TColors.primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            ///Title
            TextFormField(
              keyboardType: TextInputType.text,
              controller: titleController,
              expands: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.secondaryColor),
                  ),
                  labelText: TText.title,
                  labelStyle: const TextStyle(color: TColors.primaryColor),
                  prefixIcon: const Icon(Iconsax.note),
                  prefixIconColor: TColors.primaryColor),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Email
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              expands: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.secondaryColor),
                  ),
                  labelText: TText.email,
                  labelStyle: const TextStyle(color: TColors.primaryColor),
                  prefixIcon: const Icon(Iconsax.direct),
                  prefixIconColor: TColors.primaryColor),
            ),

            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Phone Number
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phone,
              expands: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.secondaryColor),
                  ),
                  labelText: TText.phoneNo,
                  labelStyle: const TextStyle(color: TColors.primaryColor),
                  prefixIcon: const Icon(Iconsax.call),
                  prefixIconColor: TColors.primaryColor),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Password
            TextFormField(
              obscureText: true,
              controller: password,
              expands: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: TColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: TColors.secondaryColor),
                ),
                labelText: TText.password,
                labelStyle: const TextStyle(color: TColors.primaryColor),
                prefixIcon: const Icon(Iconsax.password_check),
                prefixIconColor: TColors.primaryColor,
                suffixIcon: const Icon(Iconsax.eye_slash),
                suffixIconColor: TColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Confirm password
            TextFormField(
              obscureText: true,
              controller: confirmPassword,
              expands: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: TColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: TColors.secondaryColor),
                ),
                labelText: TText.confirmPassword,
                labelStyle: const TextStyle(color: TColors.primaryColor),
                prefixIcon: const Icon(Iconsax.password_check),
                prefixIconColor: TColors.primaryColor,
                suffixIcon: const Icon(Iconsax.eye_slash),
                suffixIconColor: TColors.primaryColor,
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            const TermsAndConditionsCheckbox(),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Create Account Btn
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primaryColor,
                    side: const BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  cubit.Register(
                      email: email.text,
                      password: password.text,
                      name: '${firstName.text} ${lastName.text}',
                      phone: phone.text,
                      title: titleController.text);
                  if (state is RegisterFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'error',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ));
                  }
                  else if (state is RegisterSuccess) {
                    navigateToToFinish(context, const VerifyEmailScreen());
                  }
                },
                child: const Text(
                  TText.createAccount,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}
