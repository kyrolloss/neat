import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neat/Screens/chat/services/auth_services.dart';
import 'package:neat/Screens/chat/services/chat_service.dart';
import 'package:neat/Screens/chat/widgets/user_tile.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:neat/common/widgets/drawer/drawer.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: Column(
        children: [
          TPrimaryHeaderContainer(
            child: Column(
              children: [
                TAppBar(
                  showBackArrow: true,
                  iconColor: TColors.backgroundColor,
                  backgroundColor: TColors.primaryColor,
                  title: const Text(
                    "Chats",
                    style: TextStyle(color: TColors.backgroundColor),
                  ),
                ),
                const SizedBox(
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
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: TColors.primaryColor,
          );
        }
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

  /// build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    /// display all users except current user
    if (_authService.getCurrentUser()!.email != userData['email']) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserTile(
          text: userData['name'],
          onTap: () {
            /// tapped on user -> go to chat page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                    receiverUserEmail: userData['email'],
                    receiverUserID: userData['uid']),
              ),
            );
          },
        ),
      );
    } else {
      /// return empty container
      return Container();
    }
  }
}
