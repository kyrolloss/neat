import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat/Screens/Profile/widgets/profile_menu.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/widgets/images/circular_image.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../cubit/app_cubit.dart';
import '../../utlis/constants/colors.dart';
import '../../utlis/constants/image_strings.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  File? file;
  String? url;

  // late SharedPreferences _prefs;
  // late String _photoUrl;
  var database = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // _initPrefs();
    //  _loadPhotoUrl();
  }

  // _initPrefs() async{
  //   _prefs = await SharedPreferences.getInstance();
  // }
  // _loadPhotoUrl() async{
  //
  //   _photoUrl = _prefs.getString('photoUrl') ?? '';
  //   setState(() {
  //
  //   });
  // }
  // _savePhotoUrl(String photoUrl) async{
  //
  //   await _prefs.setString('photoUrl', photoUrl);
  //   _photoUrl =photoUrl;
  // }

  getImageGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    /// Pick an image.
    final XFile? imageGallery =
        await picker.pickImage(source: ImageSource.camera);
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

      // if (kDebugMode) {
      //   print(imageName);
      // }
      // if (kDebugMode) {
      //   print('************************************************');
      // }
      // if (kDebugMode) {
      //   print(imageName);
      // }
      var refStorage = FirebaseStorage.instance.ref("ProfileImg/$imageName");
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
      await database
          .collection('Users')
          .doc(AppCubit.get(context).id)
          .update({
        'url': url,
      });
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

    setState(() {
      if (imageGallery != null) {
        file = File(imageGallery.path);
      } else {
        showSnackBar("No profile Selected", const Duration(milliseconds: 400));
      }
    });

    getImagesAndFolderName() async {
      var ref = await FirebaseStorage.instance.ref("ProfileImg").list();
      for (var element in ref.items) {
        if (kDebugMode) {
          print("**********");
        }
        if (kDebugMode) {
          print(element.name);
        }
      }
    }
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        // _loadPhotoUrl();
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDarkMode
                      ? TColors.secondaryColor
                      : TColors.primaryColor,
                )),
            iconTheme: const IconThemeData(
              color: TColors.primaryColor,
            ),
            title: const Text("Profile"),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium!.apply(
                color:
                    isDarkMode ? TColors.secondaryColor : TColors.primaryColor),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Profile Picture

                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                              height: 120,
                              width: 120,
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
                            bottom: -10,
                            right: -6,
                            child: IconButton(
                              onPressed: () async {
                                final imageUrl = await getImageGallery(context);
                                if (imageUrl != null) {
                                  setState(() {
                                    url = imageUrl;
                                  });
                                  // _savePhotoUrl(imageUrl);
                                }
                                TCircularImage(
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
                          child: Text(
                            "Change Profile Picture",
                            style: TextStyle(
                                color: isDarkMode
                                    ? TColors.secondaryColor
                                    : TColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Profile Information
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(
                    color: TColors.secondaryColor,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// Heading Profile Info
                  TSectionHeading(
                    title: "Profile Information",
                    showActionButton: false,
                    textColor: isDarkMode
                        ? TColors.secondaryColor
                        : TColors.primaryColor,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  TProfileMenu(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: '  Write The New Value ...',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          cubit.updateUserInfo(
                                              'name', nameController.text);
                                          nameController.clear();
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.done_all))),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    title: 'name',
                    value: cubit.name,
                  ),
                  TProfileMenu(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      hintText: '  Write The New Value ...',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.updateUserInfo(
                                                'title', titleController.text);
                                            titleController.clear();
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.done_all))),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      title: "title",
                      value: cubit.title),

                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(
                    color: TColors.secondaryColor,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// Heading Personal Information
                  TSectionHeading(
                    title: "Personal Information",
                    showActionButton: false,
                    textColor: isDarkMode
                        ? TColors.secondaryColor
                        : TColors.primaryColor,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: TSizes.spaceBtwItems / 1.5),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "User ID",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(color: TColors.textPrimary),
                                overflow: TextOverflow.ellipsis,
                              )),
                          Expanded(
                            flex: 5,
                            child: Text(
                              cubit.id,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: TColors.darkerGrey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Expanded(
                              child: Icon(
                            Icons.copy_rounded,
                            size: 18,
                            color: TColors.primaryColor,
                          )),
                        ],
                      ),
                    ),
                  ),

                  TProfileMenu(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      hintText: '  Write The New Value ...',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.updateUserInfo(
                                                'email', emailController.text);
                                            emailController.clear();
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.done_all))),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      title: "E-mail",
                      value: cubit.email),
                  TProfileMenu(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                      hintText: '  Write The New Value ...',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.updateUserInfo(
                                                'phone', phoneController.text);
                                            phoneController.clear();
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.done_all))),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      title: "Phone Number",
                      value: cubit.phone),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
