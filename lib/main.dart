import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/Task%20template%20Screen.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'Screens/Task template Screen.dart';
import 'Screens/authentication/screens/onboarding/onboarding_screen.dart';
import 'firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppCubit Cubit;

  @override
  void initState() {
    super.initState();
    Cubit = AppCubit();
    Cubit.initialize();
  }

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
