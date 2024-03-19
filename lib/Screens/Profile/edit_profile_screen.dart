import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat/Screens/Profile/widgets/profile_menu.dart';
import 'package:neat/utils.dart';
import 'package:neat/utlis/constants/sizes.dart';
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
  Uint8List? _image;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
       appBar: AppBar(
         backgroundColor: TColors.backgroundColor,
         automaticallyImplyLeading: true,
         iconTheme: IconThemeData(color: TColors.primaryColor,),
         title: Text("Profile"),
         titleTextStyle: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.primaryColor),


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

                       const TCircularImage(
                        image: TImages.user,
                        width: 80,
                        height: 80,
                      ),
                      Positioned(
                        bottom: -10,
                        left: 45,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo_outlined,
                            color: TColors.primaryColor,
                          ),
                        ),
                      ),
                    ]),
                    TextButton(
                      onPressed: ()  {

                      },
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

              TProfileMenu(onPressed: () {
                showDialog(context: context, builder: (context) {


                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nameController,

                        decoration:  InputDecoration(

                          hintText: '  Write The New Value ...',
                            suffixIcon: IconButton(onPressed: (){
                              cubit.updateUserInfo('name', nameController.text);
                              nameController.clear();
                              Navigator.pop(context);
                            }, icon: const Icon(Icons.done_all))
                        ),
                      ),
                    ),
                  );
                },);
              }, title: 'name', value:cubit.name ),
              TProfileMenu(
                  onPressed: () {

                    showDialog(context: context, builder: (context) {


                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: titleController,

                            decoration:  InputDecoration(

                                hintText: '  Write The New Value ...',
                                suffixIcon: IconButton(onPressed: (){
                                  cubit.updateUserInfo('title', titleController.text);
                                  titleController.clear();
                                  Navigator.pop(context);
                                }, icon: const Icon(Icons.done_all))
                            ),
                          ),
                        ),
                      );
                    },);
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
              const TSectionHeading(
                title: "Personal Information",
                showActionButton: false,
                textColor: TColors.primaryColor,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

            GestureDetector(
              onTap: (){},
              child: Padding(padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems/1.5),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text( "User ID",
                          style: Theme.of(context).textTheme.bodySmall!.apply(color: TColors.textPrimary) ,
                          overflow: TextOverflow.ellipsis,
                        )),

                    Expanded(
                      flex: 5,
                      child: Text(cubit.id,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.darkerGrey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Expanded(
                        child: Icon(Icons.copy_rounded,
                          size: 18,
                          color: TColors.primaryColor,
                        )),

                  ],
                ),
              ),
            ),


              TProfileMenu(
                  onPressed: () {

                    showDialog(context: context, builder: (context) {


                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailController,

                            decoration:  InputDecoration(

                                hintText: '  Write The New Value ...',
                                suffixIcon: IconButton(onPressed: (){
                                  cubit.updateUserInfo('email', emailController.text);
                                  emailController.clear();
                                  Navigator.pop(context);
                                }, icon: const Icon(Icons.done_all))
                            ),
                          ),
                        ),
                      );
                    },);
                  },
                  title: "E-mail",
                  value:cubit.email),
              TProfileMenu(
                  onPressed: () {
                    showDialog(context: context, builder: (context) {


                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: phoneController,

                            decoration:  InputDecoration(

                                hintText: '  Write The New Value ...',
                                suffixIcon: IconButton(onPressed: (){
                                  cubit.updateUserInfo('phone', phoneController.text);
                                  phoneController.clear();
                                  Navigator.pop(context);
                                }, icon: const Icon(Icons.done_all))
                            ),
                          ),
                        ),
                      );
                    },);
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
