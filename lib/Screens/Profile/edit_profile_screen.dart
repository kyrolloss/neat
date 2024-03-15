import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat/Screens/Profile/widgets/profile_menu.dart';
import 'package:neat/utils.dart';
import 'package:neat/utlis/constants/sizes.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/images/circular_image.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utlis/constants/colors.dart';
import '../../utlis/constants/image_strings.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Uint8List? _image;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: TAppBar(
        showBackArrow: true,
        backgroundColor: TColors.backgroundColor,
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineLarge!.apply(
                color: TColors.primaryColor,
              ),
        ),
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
                    Stack(
                        children: [
                          _image!= null ?
                          CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          ) :

                       TCircularImage(
                        image: TImages.user,
                        width: 80,
                        height: 80,
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo_outlined,
                            color: TColors.primaryColor,
                          ),
                        ),
                        bottom: -10,
                        left: 45,
                      ),
                    ]),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Change Profile Picture",
                        style: TextStyle(color: TColors.primaryColor),
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
              const TSectionHeading(
                title: "Profile Information",
                showActionButton: false,
                textColor: TColors.primaryColor,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              TProfileMenu(onPressed: () {}, title: "Name", value: "Username"),
              TProfileMenu(
                  onPressed: () {},
                  title: "Username",
                  value: "Username@gmail.com"),

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
              const TSectionHeading(
                title: "Personal Information",
                showActionButton: false,
                textColor: TColors.primaryColor,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              TProfileMenu(onPressed: () {}, title: "User ID", value: "456789"),
              TProfileMenu(
                  onPressed: () {},
                  title: "E-mail",
                  value: "username@gmail.com"),
              TProfileMenu(
                  onPressed: () {},
                  title: "Phone Number",
                  value: "0122 545 5546"),
              TProfileMenu(
                  onPressed: () {},
                  title: "Date of Birth",
                  value: "1 Oct 2001"),
            ],
          ),
        ),
      ),
    );
  }
}
