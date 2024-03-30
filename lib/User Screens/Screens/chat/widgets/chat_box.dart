import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../utlis/constants/colors.dart';

class ChatBox extends StatelessWidget {
   ChatBox({
    super.key,
  });
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TCircularContainer(
            radius: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextField(
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
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send_rounded,
                      color: TColors.primaryColor,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}