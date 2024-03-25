import 'package:flutter/material.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';

import '../../../components/color.dart';
import '../../../utlis/constants/colors.dart';

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
       this.subTitle,
      this.trailing,
        this.onTap,
      });

  final IconData icon;
  final String title;
      final String? subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode;
    return TCircularContainer(
      padding: EdgeInsets.only(bottom: 5),
      height: 55,
      radius: 50,
      child: ListTile(
        leading: Icon(icon, size: 28, color:  TColors.primaryColor,),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium!.apply(color: dark? TColors.secondaryColor : TColors.primaryColor),),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
