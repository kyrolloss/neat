
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/Profile/edit_profile_screen.dart';
import 'package:neat/Screens/authentication/screens/login/login_screen.dart';
import 'package:neat/Screens/chat/chat_screen.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:neat/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:neat/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:neat/common/widgets/texts/section_heading.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';

import '../../components/Text.dart';
import '../../components/color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                /// -- AppBar
               const TAppBar(

                  backgroundColor: TColors.primaryColor,

                ),

                /// User Profile Card
                TUserProfileTile(onPressed: (){
                  navigateTo(context, const EditProfileScreen());
                },),
                const SizedBox(height: TSizes.spaceBtwSections,),
              ],
            )),

            /// -- Body
            Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// -- Account Settings
                const TSectionHeading(
                  title: "Account Settings",
                  showActionButton: false,
                  textColor: TColors.primaryColor,
                ),

                const SizedBox(height: TSizes.spaceBtwItems,),
                Container(
                  height: height * .225,
                  width: width * .9,
                  decoration: BoxDecoration(
                      color: AppColor.primeColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amazing!",
                          style: TextStyle(
                              color: AppColor.secondColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * .1,
                                  width: width * .5,
                                  child: Center(
                                    child: BuildText(
                                      text: 'You have completed 41 tasks!',
                                      color: AppColor.secondColor,
                                      size: 20,
                                      bold: true,
                                      maxLines: 3,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: height * .03,
                            width: width * .3,
                            decoration: BoxDecoration(
                              color: AppColor.secondColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: BuildText(
                                text: "Details",
                                color: AppColor.primeColor,
                                size: 17.5,
                                bold: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),

                TSettingsMenuTile(icon: Iconsax.user, title: "Account Information",onTap: (){
                  navigateTo(context, const ChatScreen());
                },),
                const SizedBox(height: TSizes.spaceBtwItems,),
                const TSettingsMenuTile(icon: Icons.language, title: "Language"),
                const SizedBox(height: TSizes.spaceBtwItems,),
                const TSettingsMenuTile(icon: Icons.settings_suggest_outlined, title: "Settings",  ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                 TSettingsMenuTile(icon: Icons.logout_sharp, title: "Logout",onTap: (){
                  navigateTo(context, const LoginScreen());
                },)
              ],
            ),
            ),

          ],
        ),
      ),
    );
  }
}
