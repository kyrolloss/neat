import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/chat/services/chat_services.dart';
import 'package:neat/Screens/chat/widgets/chat_box.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/common/widgets/images/circular_image.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/image_strings.dart';
import 'package:neat/utlis/constants/sizes.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatScreen(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    /// only send message if there is something to send
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);

      /// Clear the controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.primaryColor,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        )),
        title: Row(
          children: [
            const TCircularImage(image: TImages.user),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.receiverUserEmail,
              style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Messages
            Expanded(child: _buildMessageList(),
            ),
            /// User Input
            _buildMessageInput();
        ],
        ),
      )),
    );
  }
}

/// build Message List

/// build Message Item
Widget _buildMessageItem (DocumentSnapshot document){
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  /// align the messages to the right if the sender is the current user , otherwise to the left
  var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid) ?  Alignment.centerRight : Alignment.centerLeft;
  return Container(
    alignment: alignment,
    child: Column(
      children: [
        Text(data['senderEmail']),
        Text(data['message']),
      ],
    ),
  );
}
/// build Message Input
Widget _buildMessageInput(){
  return Row(
    children: [
      ChatBox(),
    ],
  );
}