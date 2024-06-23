import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inkblob_navigation_bar/inkblob_navigation_bar.dart';
import 'package:neat/components/color.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:provider/provider.dart';

import '../utlis/constants/themes/theme_provider.dart';
import 'Home/home Screen.dart';

class AdminMainLayout extends StatefulWidget {
  int buttomIndex = 0;
  final String uid;
  Widget? widget;

  AdminMainLayout({super.key, required this.uid}) {
    widget = adminHomeScreen();
  }

  @override
  State<AdminMainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<AdminMainLayout> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int _page = 0;

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

    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance
            .collection('Notification')
            .doc(AppCubit.get(context).id)
            .collection(AppCubit.get(context).id)
    .snapshots();


    notificationStream.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docChanges.forEach((change) async {
        if (change.type == DocumentChangeType.modified) {
          var taskData = change.doc.data();
          var taskStatus = taskData?['status'];

          showNotification(snapshot.docs.first, taskData!['yearCompleted'], taskData['monthCompleted'], taskData['dayCompleted']);
        }
      });
    });

    notificationStream.listen((event) async {
      if (event.docs.isEmpty) {
        return;
      }

      var lastDoc = event.docs.last;
      var taskId = lastDoc['id'];

      var notificationDoc = await FirebaseFirestore.instance
          .collection('Notification')
          .doc(AppCubit.get(context).id)
          .collection('notification')
          .doc(taskId)
          .get();

      if (!notificationDoc.exists) {
        await FirebaseFirestore.instance
            .collection('Notification')
            .doc(AppCubit.get(context).id)
            .collection('notification')
            .doc(taskId)
            .set(lastDoc.data());

        await showNotification(
            lastDoc, lastDoc['yearCompleted'], lastDoc['monthCompleted'], lastDoc['dayCompleted']);
      }
    });
  }

  String channelId = '1';


  showNotification(
    QueryDocumentSnapshot<Map<String, dynamic>> event,
    String year,
    String month,
    String day,
  ) {
    print('get nof');
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, 'Notify my',
            channelDescription: 'to send Local Notification',
            importance: Importance.high);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: null,
        macOS: null,
        linux: null);

    flutterLocalNotificationsPlugin.show(
      01, // id للإشعار
      event.get('receiverName'),'',

      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: bottomNavigationKey,
            index: 0,
            items: const [
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  label: 'Home',
                  labelStyle: TextStyle(color: Colors.white)),
              CurvedNavigationBarItem(
                  child:
                      Icon(Icons.calendar_month_outlined, color: Colors.white),
                  label: 'Calendar',
                  labelStyle: TextStyle(color: Colors.white)),
              CurvedNavigationBarItem(
                  child:
                      Icon(Icons.add_circle_outline_sharp, color: Colors.white),
                  label: 'Send Task',
                  labelStyle: TextStyle(color: Colors.white)),
              CurvedNavigationBarItem(
                  child: Icon(Icons.notifications_none, color: Colors.white),
                  label: 'Notifications',
                  labelStyle: TextStyle(color: Colors.white)),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.white,
                  ),
                  label: 'Personal',
                  labelStyle: TextStyle(color: Colors.white)),
            ],
            color: AppColor.primeColor,
            buttonBackgroundColor: AppColor.primeColor,
            backgroundColor:
                isDarkMode ? Colors.grey.shade900 : TColors.backgroundColor,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 450),
            onTap: (index) {
              setState(() {
                _page = index;
                widget.widget = cubit.adminPagesNames[index];
              });
            },
            letIndexChange: (index) => true,
          ),
          body: widget.widget,
        );
      },
    );
  }
}
