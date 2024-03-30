import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu(
      {super.key,
        this.icon = Iconsax.arrow_right_34,
        required this.onPressed,
        required this.title,
        required this.value,
      });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context,listen: false).isDarkMode;
    return GestureDetector(
      onTap: onPressed,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems/1.5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
              child: Text(title,
              style: Theme.of(context).textTheme.bodySmall!.apply(
                  color:isDarkMode ? TColors.secondaryColor : TColors.primaryColor) ,
                overflow: TextOverflow.ellipsis,
              )),

          Expanded(
            flex: 5,
            child: Text(value,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: isDarkMode ? TColors.primaryColor.withOpacity(0.9) : TColors.darkerGrey ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
              child: Icon(icon,
          size: 18,
                color: TColors.primaryColor,
          )),

        ],
      ),
      ),
    );
  }
}
