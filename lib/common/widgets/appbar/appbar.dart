import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
        this.backgroundColor
      });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        backgroundColor: backgroundColor ,
        automaticallyImplyLeading: false,
        leading: showBackArrow ? IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Iconsax.arrow_left2,color: TColors.primaryColor,))
      : leadingIcon != null
          ? IconButton(onPressed: (){}, icon: Icon(leadingIcon)) : null,

        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
