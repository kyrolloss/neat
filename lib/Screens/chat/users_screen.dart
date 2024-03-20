import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neat/Screens/chat/services/auth_services.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/common/widgets/custom_shapes/containers/primary_header_container.dart';
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
  void signOut() {
    /// get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  actions: [
                    IconButton(
                        onPressed: signOut,
                        icon: const Icon(
                          Icons.logout,
                          color: TColors.backgroundColor,
                        ))
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
           Container(
             height: 85,
               child: _buildUserList()),

        ],
      ),
    );
  }

  /// build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(
            color: TColors.primaryColor,
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  /// build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    /// display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return TCircularContainer(
        backgroundColor: TColors.primaryColor,
        child: ListTile(
          title: Text(data['email'],style: TextStyle(color: TColors.backgroundColor),),
          onTap: () {
            /// pass the clicked user's UID to the chat page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          receiverUserEmail: data['email'],
                          receiverUserID: data['uid'],
                        )));
          },
        ),
      );
    } else {
      /// return empty container
      return Container();
    }
  }
}
