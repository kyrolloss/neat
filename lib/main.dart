import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/Notification/notification%20services/notification%20services.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'Screens/authentication/screens/onboarding/onboarding_screen.dart';
import 'firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child:  MaterialApp(
        navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false, home: OnboardingScreen()),
    );
  }
}
