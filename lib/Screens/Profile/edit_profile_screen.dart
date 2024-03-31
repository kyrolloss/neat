import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat/Screens/Profile/widgets/profile_menu.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';
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

  getImageGallery() async{
    final ImagePicker picker = ImagePicker();

    /// Pick an image.
    final XFile? imageGallery = await picker.pickImage(source: ImageSource.gallery);
    file =File(imageGallery!.path);
    setState(() {
    });



  }



  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
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
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Stack(children: [
                          // _image != null
                          //     ?
                          // CircleAvatar(
                          //   radius: 50,
                          // ),
                          if(file!= null) Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: Image.file(file!, fit: BoxFit.cover,),)
                          else
                          const TCircularImage(
                            image: TImages.user,
                            width: 120,
                            height: 120,
                          ),
                          Positioned(
                            bottom: -10,
                            right: -6,
                            child: IconButton(
                              onPressed: () {
                                getImageGallery();
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
                            getImageGallery();
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

                  /// Details
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

                  /// Heading Personal Info
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
