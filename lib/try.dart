import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:iconsax/iconsax.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/text_strings.dart';

class FirestoreNotifications extends StatefulWidget {

  @override
  _FirestoreNotificationsState createState() => _FirestoreNotificationsState();
}

class _FirestoreNotificationsState extends State<FirestoreNotifications> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
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

    var auth = FirebaseAuth.instance;

    User? getCurrentUser() {
      return auth.currentUser;
    }

    print(getCurrentUser()!.uid);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    String UserId = getCurrentUser()!.uid;

    List<String> ids = [UserId, receiverId];

    ids.sort();
    String taskRoomId = ids.join('_');
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
    FirebaseFirestore.instance.collection('tasks_rooms').doc(taskRoomId).collection('tasks')
        .snapshots();

    notificationStream.listen((event) {
      if (event.docs.isNotEmpty){
        return;
      }
      showNotification(event);
    });



  }

  String channelId = 'your_channel_id';

  showNotification(QuerySnapshot<Map<String,dynamic>>event) {
    String name = event.docs[0].data()['name'];
    String deadline = event.docs[0].data()['deadline'];
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
      0, // id للإشعار
      'New Notification',
      'Title: $name, Deadline: $deadline',
      notificationDetails,
    );
  }
  TextEditingController email = TextEditingController();
  TextEditingController titleController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _firebaseMessaging.requestPermission();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print("onMessage: $message");
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text(message.notification!.title!),
  //         content: Text(message.notification!.body!),
  //         actions: <Widget>[
  //           MaterialButton(
  //             child: Text('Close'),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print("onMessageOpenedApp: $message");
  //   });
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //   _firebaseMessaging.getToken().then((token) {
  //     print('Token: $token');
  //   });
  // }
  //
  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  // }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance.collection('tasks_rooms').snapshots();
    notificationStream.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Firestore Notifications'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            ///Title
            TextFormField(
              keyboardType: TextInputType.text,
              controller: titleController,
              expands: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.secondaryColor),
                  ),
                  labelText: TText.title,
                  labelStyle: const TextStyle(color: TColors.primaryColor),
                  prefixIcon: const Icon(Iconsax.note),
                  prefixIconColor: TColors.primaryColor),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Email
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              expands: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: TColors.secondaryColor),
                  ),
                  labelText: TText.email,
                  labelStyle: const TextStyle(color: TColors.primaryColor),
                  prefixIcon: const Icon(Iconsax.direct),
                  prefixIconColor: TColors.primaryColor),
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Create Acoount Btn
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primaryColor,
                    side: const BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: (){
                  showNotification;
                },
                child: const Text(
                  TText.createAccount,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
// StreamBuilder<QuerySnapshot>(
// stream: firestore.collection('tasks_rooms').snapshots(),
// builder: (context, snapshot) {
// if (!snapshot.hasData) {
// return const Center(
// child: CircularProgressIndicator(),
// );
// }
//
// final rooms = snapshot.data!.docs;
//
// return ListView.builder(
// itemCount: rooms.length,
// itemBuilder: (context, index) {
// final roomID = rooms[index].id;
//
// // هنا يمكنك بناء عرض العناصر بناءً على documents[index]
// return ListTile();
// },
// );
// },
// ),
