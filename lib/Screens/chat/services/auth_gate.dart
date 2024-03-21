import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/MainLayout.dart';
import 'package:neat/Screens/authentication/screens/login/login_screen.dart';
import 'package:neat/cubit/app_cubit.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                /// user is logged in
                if (snapshot.hasData) {
                  return MainLayout(uid: cubit.id);
                }

                /// user isn't logged in
                else {
                  return const LoginScreen();
                }
              }),
        );
      },
    );
  }
}
