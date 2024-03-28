import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/MainLayout.dart';
import 'package:neat/Screens/authentication/screens/signup/signup_screen.dart';
import 'package:neat/Screens/chat/services/auth_services.dart';
import 'package:neat/components/components.dart';
import 'package:provider/provider.dart';

import '../../../../../cubit/app_cubit.dart';
import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';
import '../../../../../utlis/constants/themes/theme_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  /// email and password text controllers
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();






  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: TSizes.spaceBtwSections,
      ),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          var cubit = AppCubit.get(context);

          if (state is LoginSuccess) {
            navigateTo(
                context,
                MainLayout(
                  uid: cubit.id,
                ));
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Column(
            children: [
              /// Email
              TextFormField(
                style: TextStyle(
                    color: isDarkMode ? TColors.secondaryColor : TColors.primaryColor
                ),
                controller: email,
                expands: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    prefixIcon: const Icon(Iconsax.direct_right),
                    prefixIconColor: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    labelText: TText.email,
                    filled: true,
                    fillColor:isDarkMode?TColors.primaryColor.withOpacity(0.7)  : TColors.secondaryColor ,
                    labelStyle:  TextStyle(
                      color:isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                    )),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              /// -- Password
              TextFormField(
                style: TextStyle(
                  color: isDarkMode ? TColors.secondaryColor : TColors.primaryColor
                ),
                controller: password,
                obscureText: true,
                expands: false,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    prefixIcon: const Icon(Iconsax.password_check),
                    prefixIconColor: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    labelText: TText.password,
                    filled: true,
                    fillColor:isDarkMode?TColors.primaryColor.withOpacity(0.7)  : TColors.secondaryColor ,
                    labelStyle: TextStyle(
                      color:isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                    )),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor:  isDarkMode ? TColors.secondaryColor: TColors.primaryColor,
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  onPressed: () async {
                    await cubit.Login(
                        email: email.text, password: password.text);
                  },
                  child:  Text(
                    "Log in",
                    style: TextStyle(fontSize: 18, color: isDarkMode? TColors.primaryColor : TColors.secondaryColor),
                  ),
                ),
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// Don't have account , Create account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      /// Don't have an account
                      Text(
                        TText.loginTitle,
                        style: TextStyle(color: TColors.greyColor),
                      ),
                    ],
                  ),

                  /// Create Account
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                      },
                      child: const Text(
                        TText.createAccount,
                        style: TextStyle(color:  TColors.primaryColor),
                      )),
                ],
              ),
            ],
          );
        },
      ),
    ));
  }
}
