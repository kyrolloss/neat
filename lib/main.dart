import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/Task%20template%20Screen.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'Screens/Task template Screen.dart';
import 'Screens/authentication/screens/onboarding/onboarding_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
        
          home: OnboardingScreen()
      ),
    );
  }
}
