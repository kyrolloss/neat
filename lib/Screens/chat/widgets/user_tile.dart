import 'package:flutter/material.dart';
import 'package:neat/utlis/constants/sizes.dart';

import '../../../utlis/constants/colors.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key,
    required this.text,
    this.onTap});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: TColors.secondaryColor,
        ),
        // margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
        child: Row(
          children: [
            /// Icon

            Icon(Icons.person, color: TColors.primaryColor,),
            SizedBox(width: TSizes.spaceBtwItems,),
            /// user name
            Text(text,style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primaryColor)),
          ],
        ),
      ),
    );
  }
}
