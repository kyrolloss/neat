import 'package:flutter/material.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/colors.dart';

import '../../../User Screens/Screens/Profile/profile_screen.dart';
import '../../../User Screens/Screens/chat/services/auth_services.dart';


class TDrawer extends StatelessWidget {
  const TDrawer({super.key});

  void signOut() {
    /// get auth service
    final authService = AuthService();
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: TColors.secondaryColor,
      child: Column(
        children: [
          /// Logo
          const DrawerHeader(
              child: Icon(
                Icons.task_outlined,
                color: TColors.primaryColor,
                size: 40,
              )),

          /// home list tile
          Padding(padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            title: const Text("H O M E "),
            leading: const Icon(Icons.home),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ),
          /// settings list tile
          Padding(padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("S E T T I N G S"),
              leading: const Icon(Icons.settings),
              onTap: (){
                navigateTo(context, const ProfileScreen(uid: '',));
              },
            ),
          ),
          /// logout list tile
          Padding(padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading:const  Icon(Icons.logout),
              onTap: signOut
            ),
          ),
        ],
      ),
    );
  }
}
