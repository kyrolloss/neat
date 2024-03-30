import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neat/User%20Screens/Screens/chat/services/auth_services.dart';
import 'package:neat/User%20Screens/Screens/chat/services/chat_service.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';

import 'chat_screen.dart';
import 'widgets/user_tile.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const TPrimaryHeaderContainer(
            child: Column(
              children: [
                TAppBar(
                  showBackArrow: true,
                  iconColor: TColors.backgroundColor,
                  backgroundColor: TColors.primaryColor,
                  title: Text(
                    "Chats",
                    style: TextStyle(color: TColors.backgroundColor),
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
           Expanded(
             child: _buildUserList(),
           ),

        ],
      ),
    );
  }

  /// build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream() ,
      builder: (context, snapshot) {
        /// error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        /// loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        /// return listview
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(
            color: TColors.primaryColor,
          );
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  /// build individual user list items
  Widget _buildUserListItem(Map<String, dynamic> userData , BuildContext context) {
    /// display all users except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return Padding(
        
        padding: const EdgeInsets.all(8.0),
        child: TCircularContainer(

          child: UserTile(
            text:
              userData['name'],
            onTap: () {
              /// pass the clicked user's UID to the chat page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            receiverUserEmail: userData['email'],
                            receiverUserID: userData['uid'],
                          )));
            },
          ),
        ),
      );
    } else {
      /// return empty container
      return Container();
    }
  }

}
