import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/Profile/edit_profile_screen.dart';
import 'package:neat/Screens/Profile/performance/performance.dart';
import 'package:neat/Screens/authentication/screens/login/login_screen.dart';
import 'package:neat/Screens/chat/services/auth_services.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:neat/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:neat/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:neat/common/widgets/settings_screen/settings_screen.dart';
import 'package:neat/common/widgets/texts/section_heading.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/task Model.dart';
import '../../components/Text.dart';
import '../../components/color.dart';
import '../../cubit/app_cubit.dart';
import '../authentication/screens/signup/packages Scren/packages screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /// Sign user out
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      navigateTo(context, const LoginScreen());

      AppCubit.get(context).premium = false;
      AppCubit.get(context).year = 0;
      AppCubit.get(context).month = 0;
      AppCubit.get(context).day = 0;
      AppCubit.get(context).tasksList = [];
      AppCubit.get(context).numberOfTodoTasks = 0;
      AppCubit.get(context).numberOfInProgressTasks = 0;
      AppCubit.get(context).numberOfCompletedTasks = 0;
      AppCubit.get(context).membersUnderSupervision = 0;
      AppCubit.get(context).id = '';
      AppCubit.get(context).name = '';
      AppCubit.get(context).email = '';
      AppCubit.get(context).phone = '';
      AppCubit.get(context).title = '';
      AppCubit.get(context).url;

      String typee = '';
      print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  double competedTask = 0;
  double toDoTask = 0;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// Header
                TPrimaryHeaderContainer(
                    child: Column(
                  children: [
                    /// -- AppBar
                    const TAppBar(
                      showBackArrow: false,
                      backgroundColor: TColors.primaryColor,
                      iconColor: TColors.primaryColor,
                    ),

                    /// User Profile Card
                    TUserProfileTile(
                      onPressed: () {
                        navigateTo(context, const EditProfileScreen());
                      },
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                  ],
                )),

                /// -- Body
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      /// -- Account Settings
                      TSectionHeading(
                        title: "Account Settings",
                        showActionButton: false,
                        textColor: isDarkMode
                            ? TColors.secondaryColor
                            : TColors.primaryColor,
                      ),

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
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
                                            text:
                                                'You have completed ${cubit.numberOfCompletedTasks} tasks!',
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

                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TSettingsMenuTile(
                          icon: Icons.star_rate_outlined,
                          title: "Performance",
                          onTap: () async {
                            bool isPremium = false;

                            DocumentSnapshot userDoc = await FirebaseFirestore
                                .instance
                                .collection('Users')
                                .doc(cubit.id)
                                .get();

                            if (userDoc.exists) {
                              isPremium = userDoc['premium'] ?? false;
                              print(isPremium);
                            }
                            if (isPremium == true) {
                              await cubit.getPerformance(context: context);
                            } else if (isPremium == false) {
                              navigateTo(
                                  context,
                                  const SubscriptionPage(
                                    auth: false,
                                  ));
                            }
                          }),
                      //
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TSettingsMenuTile(
                        icon: Icons.settings_suggest_outlined,
                        title: "Settings",
                        onTap: () {
                          navigateTo(context, const SettingsScreen());
                        },
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TSettingsMenuTile(
                        icon: Icons.logout_sharp,
                        title: "Logout",
                        onTap: ()async{
                          signOut();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
