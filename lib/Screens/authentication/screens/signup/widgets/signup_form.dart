import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/MainLayout.dart';
import 'package:neat/Screens/authentication/screens/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:neat/components/components.dart';
import 'package:neat/cubit/app_cubit.dart';

import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';

class SignupForm extends StatelessWidget {
  SignupForm({
    super.key,
  });

  TextEditingController firstName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController titleController = TextEditingController();

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
              height: TSizes.spaceBtwSections,
            ),

            const TermsAndConditionsCheckbox(),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Create Acoount Btn
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('error')));
                  } else if (state is RegisterSuccess) {
                    navigateToToFinish(context, MainLayout());
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
