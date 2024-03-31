import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:neat/Admin%20Screens/Main%20Layout.dart';
import 'package:neat/Admin%20Screens/Task%20template%20Screen.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'package:neat/try.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'Screens/Notification/notification services/notification services.dart';
import 'Screens/authentication/screens/onboarding/onboarding_screen.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final WidgetsBinding widgetsBinding=WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: androidInitializationSettings,
      iOS: null,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    final DocumentReference docRef =
    FirebaseFirestore.instance.collection('myCollection').doc('myDoc');

  }

  String channelId = 'your_channel_id';

  showNotification() {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, 'Notify my',
            importance: Importance.high);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: null,
        macOS: null,
        linux: null);

    flutterLocalNotificationsPlugin.show(
        01, email.text, titleController.text, notificationDetails);
  }

  TextEditingController email = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: TaskTemplateScreen(senderID: ''),
        theme: Provider.of<ThemeProvider>(context).themeData,
      ),
    );
  }
}
