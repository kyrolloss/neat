import 'package:flutter/cupertino.dart';
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
import '../../../../../utlis/constants/themes/theme_provider.dart';
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
  bool isObsecuredText = true;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          navigateToToFinish(
              context, MainLayout(uid: AppCubit.get(context).id));
        }
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
                    style: TextStyle(color: TColors.primaryColor),
                    keyboardType: TextInputType.name,
                    controller: firstName,
                    expands: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: TColors.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: TColors.secondaryColor),
                      ),
                      labelText: TText.firstName,
                      labelStyle: TextStyle(
                          color: isDarkMode
                              ? TColors.secondaryColor
                              : TColors.primaryColor),
                      prefixIcon: Icon(Iconsax.user),
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
                    style: TextStyle(color: TColors.primaryColor),
                    keyboardType: TextInputType.name,
                    controller: lastName,
                    expands: false,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: TColors.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: TColors.secondaryColor),
                        ),
                        labelText: TText.lastName,
                        labelStyle: TextStyle(
                            color: isDarkMode
                                ? TColors.secondaryColor
                                : TColors.primaryColor),
                        prefixIcon: Icon(Iconsax.user),
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
              style: TextStyle(color: TColors.primaryColor),
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
                  labelStyle: TextStyle(
                      color: isDarkMode
                          ? TColors.secondaryColor
                          : TColors.primaryColor),
                  prefixIcon: const Icon(Iconsax.note),
                  prefixIconColor: TColors.primaryColor),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Email
            TextFormField(
              style: TextStyle(color: TColors.primaryColor),
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
                  labelStyle: TextStyle(
                      color: isDarkMode
                          ? TColors.secondaryColor
                          : TColors.primaryColor),
                  prefixIcon: const Icon(Iconsax.direct),
                  prefixIconColor: TColors.primaryColor),
            ),

            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Phone Number
            TextFormField(
              style: TextStyle(color: TColors.primaryColor),
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
                  labelStyle: TextStyle(
                      color: isDarkMode
                          ? TColors.secondaryColor
                          : TColors.primaryColor),
                  prefixIcon: const Icon(Iconsax.call),
                  prefixIconColor: TColors.primaryColor),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Password
            TextFormField(
              style: TextStyle(color: TColors.primaryColor),
              obscureText:isObsecuredText,
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
                labelStyle: TextStyle(
                    color: isDarkMode
                        ? TColors.secondaryColor
                        : TColors.primaryColor),
                prefixIcon: const Icon(Iconsax.password_check),
                prefixIconColor: TColors.primaryColor,
                suffixIcon: GestureDetector(
                  onTap:(){
                    setState(() {
                      isObsecuredText = !isObsecuredText;
                    });
                  } ,
                    child: Icon(isObsecuredText
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
                suffixIconColor: TColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Confirm password
            TextFormField(
              style: TextStyle(color: TColors.primaryColor),
              obscureText: isObsecuredText,
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
                labelStyle: TextStyle(
                    color: isDarkMode
                        ? TColors.secondaryColor
                        : TColors.primaryColor),
                prefixIcon: const Icon(Iconsax.password_check),
                prefixIconColor: TColors.primaryColor,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObsecuredText = !isObsecuredText;
                      });
                    },
                    child: Icon(isObsecuredText
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
                suffixIconColor: TColors.primaryColor,
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            TermsAndConditionsCheckbox(),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Create Account Btn
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? TColors.primaryColor.withOpacity(0.7)
                        : TColors.primaryColor,
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
                },
                child: Text(
                  TText.createAccount,
                  style: TextStyle(
                      color:
                          isDarkMode ? TColors.secondaryColor : Colors.white),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}
