import 'package:flutter/material.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
        required this.message,
        required this.isCurrentUser});

  final bool isCurrentUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: isCurrentUser ? TColors.primaryColor
            : TColors.secondaryColor.withOpacity(0.9) ,
      ),
      child: Text(
        message,
        style: TextStyle(color:  isCurrentUser? TColors.backgroundColor : TColors.primaryColor),
      ),
    );
  }
}
