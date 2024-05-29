import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/Profile/edit_profile_screen.dart';
import 'package:neat/Admin%20Screens/Task%20template%20Screen.dart';
import 'package:neat/Screens/Profile/widgets/profile_picture.dart';
import 'package:neat/Screens/chat/services/auth_services.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:neat/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:neat/common/widgets/settings_screen/settings_screen.dart';
import 'package:neat/common/widgets/texts/section_heading.dart';
import 'package:neat/components/components.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../components/Text.dart';
import '../../components/color.dart';

class AdminProfileScreen extends StatefulWidget {
  final String uid;

  const AdminProfileScreen({super.key, required this.uid});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  /// Sign user out
  void signOut() {
    /// get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
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
                    ListTile(
                      /// Profile picture
                      leading: ProfilePicture(cubit: cubit, width: 60, height: 60),
                      title: Text(cubit.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: Colors.white)),
                      subtitle: Text(
                        cubit.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: TColors.secondaryColor),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            navigateTo(context, const EditProfileScreen());
                          },
                          icon: const Icon(
                            Iconsax.edit,
                            color: TColors.backgroundColor,
                          )),
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
                                                'You have completed 41 tasks!',
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
                                onTap: () async {

                                },
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

                      TSettingsMenuTile(
                        icon: Iconsax.user,
                        title: "Account Information",
                        onTap: () {
                          navigateTo(
                              context,
                              const TaskTemplateScreen(

                              ));
                        },
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                       TSettingsMenuTile(
                          icon: Icons.star_rate_outlined , title: "Performance",onTap: (){},),
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
                        onTap: signOut,
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
