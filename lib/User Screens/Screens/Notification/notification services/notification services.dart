// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationManager {
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initialize() async {
//     await
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });
//
//     // For handling notification when the app is in background
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//     });
//   }
//
//   Future<String?> getToken() async {
//     return await firebaseMessaging.getToken();
//   }
// }



import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{
  final firebaseMessaging = FirebaseMessaging.instance;

  Future <void > initNotification ()async {
    await firebaseMessaging.requestPermission();
    final fCMToken =  await firebaseMessaging.getToken();
    print(fCMToken);





  }
}