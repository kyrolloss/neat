import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'package:neat/utlis/constants/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String receiverId = 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2';

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
            .where('receiverId', isEqualTo: AppCubit.get(context).id)
            .snapshots();

    notificationStream.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }
      showNotification(event.docs.last);
    });
  }

  String channelId = '1';

  showNotification(QueryDocumentSnapshot<Map<String, dynamic>> event) {
    // String name = event.docs[0].data()['name'];
    // String deadline = event.docs[0].data()['deadline'];
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
      event.get('deadline'),

      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: const TAppBar(
        backgroundColor: TColors.backgroundColor,
        title: Text(
          "Notifications",
          style: TextStyle(
              color: TColors.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 22.5, left: 22.5),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('tasks_rooms')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data!.docs;

                return SizedBox(
                  height: height * .45,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var notification = snapshot.data!.docs[index];

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: height * .13,
                          width: width * .8,
                          decoration: BoxDecoration(
                            color: AppColor.secondColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildText(
                                  text: notification['title'],
                                  color: AppColor.primeColor,
                                  size: 15,
                                ),
                                BuildText(
                                  text: notification['body'],
                                  color: AppColor.primeColor,
                                  size: 17.5,
                                  bold: true,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      color: AppColor.primeColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: width * .02,
                                    ),
                                    BuildText(
                                      text: '15.00 pm - 16.00',
                                      color: AppColor.primeColor,
                                      size: 15,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
// SizedBox(height: height*.02,),
// BuildText(text: 'Yesterday' , color: AppColor.primeColor,size: 17.5,bold: false,),
// BuildText(text: 'Today' , color: AppColor.primeColor,size: 17.5,bold: false,),
// SizedBox(
//   height: height*.8,
//   child: ListView.builder(
//     physics: const NeverScrollableScrollPhysics(),
//
//     itemCount: 3,
//     itemBuilder: (context, index) {
//       return Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Container(
//           height: height * .13,
//           width: width * .8,
//           decoration: BoxDecoration(
//             color: AppColor.secondColor,
//             borderRadius: BorderRadius.circular(25),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 BuildText(
//                   text: 'college stuff',
//                   color: AppColor.primeColor,
//                   size: 15,
//                 ),
//
//                 BuildText(
//                   text: 'Design And Documentation meeting',
//                   color: AppColor.primeColor,
//                   size: 17.5,
//                   bold: true,
//                 ),
//
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.watch_later_outlined,
//                       color: AppColor.primeColor,
//                       size: 20,
//                     ),
//                     SizedBox(
//                       width: width * .02,
//                     ),
//                     BuildText(
//                       text: '15.00 pm - 16.00',
//                       color: AppColor.primeColor,
//                       size: 15,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   ),
// )
