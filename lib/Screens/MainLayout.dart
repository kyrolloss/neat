import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:neat/Screens/Home/home.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:provider/provider.dart';

import '../components/color.dart';
import '../utlis/constants/themes/theme_provider.dart';


class MainLayout extends StatefulWidget {
  int buttomIndex = 0;
  final String uid;
  Widget? widget;

  MainLayout({super.key, required this.uid}) {
    widget = HomeScreen(receiverId: uid);
  }

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {


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

    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
    FirebaseFirestore.instance
        .collection('tasks_rooms')
        .doc('taskRoomId')
        .collection('tasks')
        .where('receiverId', isEqualTo: AppCubit.get(context).id)
        .snapshots();

    Stream<QuerySnapshot<Map<String, dynamic>>> deadlineStream =
    FirebaseFirestore.instance
        .collection('tasks_rooms')
        .doc('taskRoomId')
        .collection('tasks')
        .where('receiverId', isEqualTo: AppCubit.get(context).id)
        .snapshots();

    deadlineStream.listen((event) async {
      if (event.docs.isEmpty) {
        return;
      }
      for (var doc in event.docs) {
        DateTime? date = DateTime.tryParse('yyyy-MM-dd');
        String year = date!.year.toString();
        String month = date.month.toString();
        int day = date.day;

        if (doc['year'] == year &&
            doc['month'] == month &&
            doc['day'] == day - 1) {
          print('deadline');
          showDeadlineNotification(doc, year, month, day);
        }
      }
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
            lastDoc, lastDoc['year'], lastDoc['month'], lastDoc['day']);
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
      event.get('name'),
      'deadline $year + $month + $day',

      notificationDetails,
    );
  }

  showDeadlineNotification(
      QueryDocumentSnapshot<Map<String, dynamic>> event,
      String year,
      String month,
      int day,
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
      01,
      event.get('name'),
      'deadline $year + $month + $day',
      notificationDetails,
    );
  }
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int _page = 0;

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
                widget.widget = cubit.pagesNames[index];
              });
            },
            letIndexChange: (index) => true,
          ),
          body: widget.widget,
        );
      },
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return BlocConsumer<AppCubit, AppState>(
  //     listener: (context, state) {
  //       // TODO: implement listener
  //     },
  //     builder: (context, state) {
  //       var cubit = AppCubit.get(context);
  //       return Scaffold(
  //         bottomNavigationBar: InkblobNavigationBar(
  //           backgroundColor: TColors.secondaryColor.withOpacity(0.9),
  //           selectedIndex: widget.buttomIndex,
  //           iconSize: 35,
  //           items: [
  //             InkblobBarItem(
  //                 emptyIcon: Icon(
  //                   Icons.home_outlined,
  //                   color: TColors.primaryColor.withOpacity(0.6),
  //                 ),
  //                 filledIcon: const Icon(
  //                   Icons.home_outlined,
  //                   color: TColors.primaryColor,
  //                 )),
  //             InkblobBarItem(
  //                 emptyIcon: Icon(
  //                   Icons.calendar_month,
  //                   color:TColors.primaryColor.withOpacity(0.6),
  //                 ),
  //                 filledIcon: const Icon(
  //                   Icons.calendar_month_outlined,
  //                   color: TColors.primaryColor,
  //                 )),
  //             InkblobBarItem(
  //                 emptyIcon: Icon(
  //                   Icons.notifications_on_outlined,
  //                   color: TColors.primaryColor.withOpacity(0.6),
  //                 ),
  //                 filledIcon: const Icon(
  //                   Icons.notifications_none,
  //                   color: TColors.primaryColor,
  //                 )),
  //             InkblobBarItem(
  //                 emptyIcon: Icon(
  //                   Icons.person_outline,
  //                   color: TColors.primaryColor.withOpacity(0.6),
  //                 ),
  //                 filledIcon: const Icon(
  //                   Icons.person_outline,
  //                   color: TColors.primaryColor,
  //                 )),
  //           ],
  //           onItemSelected: (int value) {
  //             setState(() {
  //               widget.buttomIndex = value;
  //               widget.widget = cubit.pagesNames[widget.buttomIndex];
  //             });
  //           },
  //         ),
  //         body: widget.widget,
  //       );
  //     },
  //   );
  // }
}
