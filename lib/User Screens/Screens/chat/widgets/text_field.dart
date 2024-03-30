import 'package:flutter/material.dart';
import 'package:neat/utlis/constants/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required TextEditingController messageController, this.focusNode,
  }) : _messageController = messageController;

  final TextEditingController _messageController;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      style: TextStyle(color: TColors.primaryColor),
      controller: _messageController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        hintText: "Type a message ...",
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              color: TColors.primaryColor,
            )),
        // icon: IconButton(onPressed: (){}, icon: Icon(Icons.attach_file_rounded,color: TColors.primaryColor,)),
        border: InputBorder.none,
      ),
    );
  }
}