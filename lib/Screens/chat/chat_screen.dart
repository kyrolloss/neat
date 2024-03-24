import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/Screens/chat/services/auth_services.dart';
import 'package:neat/Screens/chat/services/chat_service.dart';
import 'package:neat/Screens/chat/widgets/chat_box.dart';
import 'package:neat/Screens/chat/widgets/chat_bubble.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/common/widgets/drawer/drawer.dart';
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
  /// text controller
  final TextEditingController _messageController = TextEditingController();

  /// Chat & Auth services
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  void sendMessage() async {
    /// only send message if there is something to send
    if (_messageController.text.isNotEmpty) {

      /// send the message
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);

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
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new,
          color: Colors.white,)),

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
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: Colors.white),
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
            /// display all Messages
            Expanded(
              child: _buildMessageList(),
            ),

            /// User Input
            _buildMessageInput(),
          ],
        ),
      )),
    );
  }

  /// build Message List
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  /// build Message Item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    /// is current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    /// align the messages to the right if the sender is the current user , otherwise to the left
    var alignment =
    isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail'],style: const TextStyle(color: TColors.primaryColor),),
            const SizedBox(height: 5,),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  /// build Message Input
  Widget _buildMessageInput() {
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
                    onPressed: sendMessage,
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
