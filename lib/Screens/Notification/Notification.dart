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
import 'package:provider/provider.dart';

import '../../utlis/constants/themes/theme_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.uid});

  final String uid;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late Stream<QuerySnapshot> _deadlineStream;

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


    deadlineStream.listen((event) async{
      if (event.docs.isEmpty) {
        return;
      }
      for (var doc in event.docs) {
        DateTime? date = DateTime.tryParse('yyyy-MM-dd');
        int year=0;
        int month = 0;
        int day=0;

        if (date!= null) {
          year = date.year;
          month = date.month;
          day = date.day;
        }

        print(date);


        if (doc['deadline'] ==date){
          print('sh8aaalaaaa');
        }


        // var deadline = doc['deadline'].toDate();
        // var timeDifference = deadline.difference(DateTime.now()).inDays;
        // if (timeDifference == 1) {
        //    showNotification(deadline.docs.last);
        // }
      }
    });



    notificationStream.listen((event) async {
      if (event.docs.isEmpty) {
        return;
      }
      await FirebaseFirestore.instance
          .collection('Notification')
          .doc(AppCubit.get(context).id)
          .collection('notification')
          .add(event.docs.last.data());
      await showNotification(event.docs.last);
    });
  }




  String channelId = '1';

  showNotification(QueryDocumentSnapshot<Map<String, dynamic>> event) {
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
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: TAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        iconColor: isDarkMode ? TColors.secondaryColor : TColors.primaryColor,
        title: Text(
          "Notifications",
          style: TextStyle(
              color: isDarkMode ? TColors.secondaryColor : TColors.primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 22.5, left: 22.5),
          child: StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance
                  .collection('Notification')
                  .doc(AppCubit.get(context).id)
                  .collection('notification')
                  .snapshots(),
              builder: (context, snapshot) {


                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return SizedBox(
                  height: height,
                  child: ListView.builder(

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
                                  text: notification['name'],
                                  color: AppColor.primeColor,
                                  size: 15,
                                ),
                                BuildText(
                                  text: notification['deadline'],
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
