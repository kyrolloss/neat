import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/themes/dark_mode.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: TAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineMedium!.apply(
              color:
                  isDarkMode ? TColors.secondaryColor : TColors.primaryColor),
        ),
        showBackArrow: true,
        iconColor: isDarkMode ? TColors.secondaryColor : TColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: TCircularContainer(
          backgroundColor:
              isDarkMode ? TColors.secondaryColor : TColors.primaryColor,
          height: 55,
          radius: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// dark Mode
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      isDarkMode
                          ?CupertinoIcons.sun_max
                          : Icons.dark_mode_outlined,
                      color: isDarkMode
                          ? TColors.primaryColor
                          : TColors.secondaryColor,
                      size: 27,
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Text(
                    "Dark Mode",
                    style: Theme.of(context).textTheme.titleMedium!.apply(
                        color: isDarkMode
                            ? TColors.primaryColor
                            : TColors.secondaryColor),
                  ),
                ],
              ),

              /// Switch toggle
              CupertinoSwitch(
                  activeColor: isDarkMode
                      ? TColors.primaryColor
                      : TColors.secondaryColor,
                  trackColor: isDarkMode? TColors.primaryColor : TColors.secondaryColor,
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme())
            ],
          ),
        ),
      ),
    );
  }
}
