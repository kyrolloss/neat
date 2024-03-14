import 'package:flutter/material.dart';
import 'package:neat/Screens/Profile/profile_screen.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/sizes.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/images/circular_image.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utlis/constants/colors.dart';
import '../../utlis/constants/image_strings.dart';
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: TAppBar(
        showBackArrow: true,
        backgroundColor: TColors.backgroundColor,
        leadingOnPressed: (){
          Navigator.pop(context);
        },
        title: Text("Profile",style: Theme.of(context).textTheme.headlineLarge!.apply(color: TColors.primaryColor,),),

      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const TCircularImage(image: TImages.user,width: 80, height: 80,),
                  TextButton(onPressed: (){}, child: const Text("Change Profile Picture", style: TextStyle(color: TColors.primaryColor),),
                  ),
                ],
              ),
            ),
            /// Details
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const Divider(color: TColors.secondaryColor,),
            const SizedBox(height: TSizes.spaceBtwItems,),

            /// Heading Profile Info
            const TSectionHeading(title: "Profile Info",showActionButton: false, textColor: TColors.primaryColor,),
            const SizedBox(height: TSizes.spaceBtwItems,),
          ],
        ),
        ),
      ),
    );
  }
}
