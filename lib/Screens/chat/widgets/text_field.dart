import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neat/Screens/chat/widgets/emojis_widget.dart';

import '../../../utlis/constants/colors.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required TextEditingController messageController,
    this.focusNode,
  }) : _messageController = messageController;

  final TextEditingController _messageController;
  final FocusNode? focusNode;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool emojiShowing = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (emojiShowing)
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: EmojisWidget(
                    addEmojiToTextController: addEmojiToTextController)),
          TextField(
            focusNode: widget.focusNode,
            style: TextStyle(color: TColors.primaryColor),
            controller: widget._messageController,
            onTap: () {
              setState(() {
                emojiShowing = false;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              hintText: "Type a message ...",
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: GestureDetector(
                  onTap: toggleEmojiPicker,
                  child: Icon(
                    emojiShowing
                        ? Icons.keyboard_alt_outlined
                        : Icons.emoji_emotions_outlined,
                    color: TColors.primaryColor,
                  )),
              // icon: IconButton(onPressed: (){}, icon: Icon(Icons.attach_file_rounded,color: TColors.primaryColor,)),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  void toggleEmojiPicker() {
    setState(() {
      emojiShowing = !emojiShowing;
    });

    if (emojiShowing) {
      FocusScope.of(context).unfocus();
    }
  }

  addEmojiToTextController({required Emoji emoji}) {
    setState(() {
      widget._messageController.text =
          widget._messageController.text + emoji.emoji;
      widget._messageController.selection = TextSelection.fromPosition(
          TextPosition(offset: widget._messageController.text.length));
    });
  }
}
