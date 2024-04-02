import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat/Screens/authentication/screens/login/login_screen.dart';
import 'package:neat/Screens/authentication/screens/signup/widgets/enum/user_role.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/images/circular_image.dart';
import 'package:neat/common/widgets/success_screen/success_screen.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/image_strings.dart';
import 'package:path/path.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';

class AdminOrUserScreen extends StatefulWidget {
  const AdminOrUserScreen({super.key});

  @override
  State<AdminOrUserScreen> createState() => _AdminOrUserScreenState();
}

class _AdminOrUserScreenState extends State<AdminOrUserScreen> {
  File? file;
  String? url;
  var database = FirebaseFirestore.instance;
  UserRole selectedRole = UserRole.User;

  @override
  void initState() {
    super.initState();
    // _initPrefs();
    //  _loadPhotoUrl();
  }

  getImageGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    /// Pick an image.
    final XFile? imageGallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageGallery != null) {
      // if (kDebugMode) {
      //   print('******');
      // }
      // if (kDebugMode) {
      //   print(imageGallery.path);
      // }
      file = File(imageGallery!.path);
      // if (kDebugMode) {
      //   print(imageGallery.path);
      // }
      var imageName = basename(imageGallery!.path);

      /// start upload
      var random = Random().nextInt(10000000);
      imageName = "$random$imageName";

      var refStorage = FirebaseStorage.instance.ref("ProfileImg/$imageName");
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
      // if (kDebugMode) {
      //   print(imageName);
      // }
      // if (kDebugMode) {
      //   print('************************************************');
      // }
      // if (kDebugMode) {
      //   print(imageName);
      // }
      var docRef =
          database.collection('Users').doc('f1xQHnHVneTjbxT9wMqTlAQutS63');
      var docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update({
          'url': url,
        });
      } else {
        // Handle the case where the document does not exist
        if (kDebugMode) {
          print('Document does not exist');
        }
      }

      AppCubit.get(context).url = url;
      // if (kDebugMode) {
      //   print('url : $url');
      // }
      /// end upload
    } else {
      if (kDebugMode) {
        print("Please choose Image");
      }
    }
    showSnackBar(String snackText, Duration d) {
      final snackBar = SnackBar(
        content: Text(snackText),
        duration: d,
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    }

    setState(() {
      if (imageGallery != null) {
        file = File(imageGallery.path);
      } else {
        showSnackBar("No profile Selected", const Duration(milliseconds: 400));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: TColors.backgroundColor,
          appBar: TAppBar(
            backgroundColor: TColors.backgroundColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                              height: 250,
                              width: 250,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: cubit.url != null && cubit.url!.isNotEmpty
                                  ? ClipOval(
                                      child: Image.network(
                                        cubit.url!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/user/user.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                          Positioned(
                            bottom: 3,
                            right: 20,
                            child: IconButton(
                              onPressed: () async {
                                final imageUrl = await getImageGallery(context);
                                if (imageUrl != null) {
                                  setState(() {
                                    url = imageUrl;
                                  });
                                  // _savePhotoUrl(imageUrl);
                                }
                                const TCircularImage(
                                  image: TImages.user,
                                  height: 120,
                                  width: 120,
                                );
                              },
                              icon: const Icon(
                                Icons.add_a_photo_outlined,
                                color: TColors.primaryColor,
                              ),
                            ),
                          ),
                        ]),
                        TextButton(
                          onPressed: () {
                            if (url!.isNotEmpty) Image.network(cubit.url!);
                          },
                          child: const Text(
                            "Add Profile Picture",
                            style: TextStyle(color: TColors.primaryColor),
                          ),
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwSections * 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedRole = UserRole.User;

                                  });
                                },
                                child: Text(
                                  "User",
                                  style: TextStyle(
                                      color: selectedRole == UserRole.User
                                          ? TColors.backgroundColor
                                          : TColors.primaryColor),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    selectedRole == UserRole.User
                                        ? TColors.primaryColor
                                        : TColors.backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedRole = UserRole.Admin;

                                  });
                                },
                                child: Text(
                                  "Admin",
                                  style: TextStyle(
                                      color: selectedRole == UserRole.Admin
                                          ? TColors.backgroundColor
                                          : TColors.primaryColor),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    selectedRole == UserRole.Admin
                                        ? TColors.primaryColor
                                        : TColors.backgroundColor,
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                        SizedBox(height: TSizes.spaceBtwSections,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _navigateToSuccessScreen(context);
                                  });
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      color:TColors.backgroundColor),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      TColors.primaryColor
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToSuccessScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SuccessScreen(
              image: TImages.staticSuccessIllustration2,
              title: TText.yourAccountCreatedTitle,
              subTitle: TText.yourAccountCreatedSubTitle,
              onPressed: () {
                navigateTo(context, LoginScreen());
              },
            )));
  }
}
