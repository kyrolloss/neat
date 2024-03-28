import 'package:flutter/material.dart';
import 'package:neat/Screens/Profile/profile_screen.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/colors.dart';

import '../../../Screens/chat/services/auth_services.dart';

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
          DrawerHeader(
              child: Icon(
                Icons.task_outlined,
                color: TColors.primaryColor,
                size: 40,
              )),

          /// home list tile
          Padding(padding: EdgeInsets.only(left: 25.0),
          child: ListTile(
            title: Text("H O M E "),
            leading: Icon(Icons.home),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ),
          /// settings list tile
          Padding(padding: EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.settings),
              onTap: (){
                navigateTo(context, ProfileScreen(uid: '',));
              },
            ),
          ),
          /// logout list tile
          Padding(padding: EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: signOut
            ),
          ),
        ],
      ),
    );
  }
}
