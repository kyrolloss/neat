import 'package:flutter/material.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar(
      {super.key,
        this.title,
        this.showBackArrow = false,
        this.leadingIcon,
        this.actions,
        this.leadingOnPressed,
        this.backgroundColor,
        this.iconColor
      });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(

        backgroundColor: backgroundColor ,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ?  IconButton(
          onPressed: () {
          Navigator.pop(context);
        },

          icon:Icon(Icons.arrow_back_ios,
              color: iconColor),)
        : leadingIcon != null
            ? IconButton(
            onPressed: leadingOnPressed,
            icon: Icon(leadingIcon)) : null,
        title: title,
        actions: actions,

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
