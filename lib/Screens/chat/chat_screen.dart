import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/Profile/widgets/profile_picture.dart';
import 'package:neat/Screens/chat/services/auth_services.dart';
import 'package:neat/Screens/chat/services/chat_service.dart';
import 'package:neat/Screens/chat/widgets/chat_bubble.dart';
import 'package:neat/Screens/chat/widgets/text_field.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/common/widgets/images/circular_image.dart';
import 'package:neat/cubit/app_cubit.dart';
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

  /// for text-field focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    /// add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        /// cause a delay so that the keyboard has time to show up
        /// then the amount of remaining space will be calculated ,
        /// then scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    /// wait a bit for listview to be built , then scroll to bottom
    Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  /// scroll controller
  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    /// only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      /// send the message
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);

      /// Clear the controller after sending the message
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: TColors.primaryColor,
            automaticallyImplyLeading: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )),
            title: Row(
              children: [
                /// Fetch and display receiver's profile picture
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(widget.receiverUserID)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error : ${snapshot.error}');
                    } else {
                      var userData = snapshot.data?.data();
                      var receiverImageUrl = userData?['url'];
                      return Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: receiverImageUrl != null &&
                                  receiverImageUrl!.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    receiverImageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const ClipOval(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/user/user.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ));
                    }
                  },
                ),
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
      },
    );
  }

  /// build Message List
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverUserID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  /// build Message Item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    /// is current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    /// align the messages to the right if the sender is the current user , otherwise to the left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(isCurrentUser
                ? _authService.getCurrentUser()!.uid
                : widget.receiverUserID)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error : ${snapshot.error}");
          } else {
            var userData = snapshot.data?.data();
            var profileImageUrl = userData?['url'];
            return Container(
              alignment: alignment,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: isCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  // (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  //     ? CrossAxisAlignment.end
                  //     : CrossAxisAlignment.start,
                  mainAxisAlignment: isCurrentUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  // (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  //     ? MainAxisAlignment.end
                  //     : MainAxisAlignment.start,
                  children: [
                    Text(
                      data['senderEmail'],
                      style: const TextStyle(color: TColors.primaryColor),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      if (!isCurrentUser) ...[
                        ClipOval(
                          child: profileImageUrl != null &&
                                  profileImageUrl.isNotEmpty
                              ? Image.network(
                                  profileImageUrl,
                                  fit: BoxFit.cover,
                                  width: 35,
                                  height: 35,
                                )
                              : Image.asset(
                                  'assets/images/user/user.png',
                                  fit: BoxFit.cover,
                                  width: 35,
                                  height: 35,
                                ),
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                      Flexible(
                        child: ChatBubble(
                          message: data['message'],
                          isCurrentUser: isCurrentUser,
                        ),
                      ),
                      if (isCurrentUser) ...[
                        const SizedBox(
                          width: 8,
                        ),
                        ClipOval(
                          child: profileImageUrl != null &&
                                  profileImageUrl.isNotEmpty
                              ? Image.network(
                                  profileImageUrl,
                                  fit: BoxFit.cover,
                                  width: 35,
                                  height: 35,
                                )
                              : Image.asset(
                                  'assets/images/user/user.png',
                                  fit: BoxFit.cover,
                                  width: 35,
                                  height: 35,
                                ),
                        ),
                      ],
                    ]),
                  ],
                ),
              ),
            );
          }
        });
  }

  /// build Message Input
  Widget _buildMessageInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TCircularContainer(
            backgroundColor: TColors.secondaryColor.withOpacity(0.9),
            radius: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(

                    child: MyTextField(
                        focusNode: myFocusNode,
                        messageController: _messageController)),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems / 2,
        ),

        /// send button
        TCircularContainer(
          backgroundColor: TColors.primaryColor,
          radius: 30,
          child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.send_rounded,
                color: TColors.backgroundColor.withOpacity(0.8),
              )),
        )
      ],
    );
  }
}
