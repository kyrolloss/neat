import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat/Screens/MainLayout.dart';
import 'package:neat/Screens/Profile/widgets/profile_picture.dart';
import 'package:neat/Screens/authentication/screens/signup/signup_screen.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/images/circular_image.dart';
import 'package:neat/common/widgets/success_screen/success_screen.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/image_strings.dart';
import 'package:path/path.dart';
import '../../../../Admin Screens/Main Layout.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';

class AdminOrUserScreen extends StatefulWidget {
  const AdminOrUserScreen({super.key, required this.email, required this.password, required this.name, required this.phone, required this.title});
  final String email;
  final String password;
  final String name;
  final String phone;
  final String title;

  @override
  State<AdminOrUserScreen> createState() => _AdminOrUserScreenState();
}

class _AdminOrUserScreenState extends State<AdminOrUserScreen> {
  String type = 'User';
  File? file;
  String? url;
  var database = FirebaseFirestore.instance;




  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {

        } else  if (state is RegisterFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'error',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
          ));
          navigateToToFinish(context, const SignupScreen());

        }      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: TColors.backgroundColor,
          appBar: const TAppBar(
            backgroundColor: TColors.backgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {

                            type = 'User';

                          });
                        },
                        child: Text(
                          "User",
                          style: TextStyle(
                              color: type == 'User'
                                  ? TColors.backgroundColor
                                  : TColors.primaryColor),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(
                                type == 'User'
                                ? TColors.primaryColor
                                : TColors.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            type = 'Admin';

                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(
                                type == 'Admin'
                                ? TColors.primaryColor
                                : TColors.backgroundColor,
                          ),
                        ),
                        child: Text(
                          "Admin",
                          style: TextStyle(
                              color: type == 'Admin'
                                  ? TColors.backgroundColor
                                  : TColors.primaryColor),
                        ),
                      ),
                    ),


                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() async{

                            await AppCubit.get(context).Register(email: widget.email, password: widget.password, name: widget.name, phone: widget.phone, title: widget.title, type: type);
                            _navigateToSuccessScreen(context , type);
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              TColors.primaryColor
                          ),
                        ),
                        child:  const Text(
                          "Done",
                          style: TextStyle(
                              color:TColors.backgroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToSuccessScreen(BuildContext context , String type) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SuccessScreen(
              image: TImages.staticSuccessIllustration2,
              title: TText.yourAccountCreatedTitle,
              subTitle: TText.yourAccountCreatedSubTitle,
          type: type,
              onPressed: () {
                if (type == 'User')
                  {navigateToToFinish(context,  MainLayout(uid: AppCubit.get(context).id));}
                else if (type =='Admin')
                  {
                    navigateToToFinish(context,  AdminMainLayout(uid: AppCubit.get(context).id));
                  }

              },
            )));
  }
}
