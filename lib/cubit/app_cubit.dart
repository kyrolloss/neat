import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:neat/Models/task%20Model.dart';
import 'package:neat/Screens/Calender%20Screen/Calender%20Screen.dart';
import 'package:neat/Screens/Home/home.dart';
import 'package:neat/Screens/Notification/Notification.dart';
import '../Screens/Profile/profile_screen.dart';
import '../main.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  DateTime? selectedDate = DateTime.tryParse('yyyy-MM-dd');
  int? year;
  int? month;
  int? day;
  List tasksList = [];
  int numberOfTodoTasks = 0;
  String id = '';
  String name = '';
  String email = '';
  String phone = '';
  String title = '';


  var auth = FirebaseAuth.instance;
  var database = FirebaseFirestore.instance;
  var storge = FirebaseStorage.instance;
  var user = FirebaseAuth.instance.currentUser;



  final FirebaseMessaging message = FirebaseMessaging.instance;



  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission for notifications
    await _firebaseMessaging.requestPermission();

    // Get the device's FCM token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Set up a listener for incoming notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: Text(message.notification!.title!),
              content: Text(message.notification!.body!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });

    // Set up a background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (message.notification != null) {
      print('Background notification received: ${message.notification!.title}/${message.notification!.body}');
    }
  }


  Future<void> getUserInfo(String uid) async {
    try {
      emit(GetUserInfoLoading());
      final DocumentReference docRef = database.collection('Users').doc(uid);

      final DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        final String userName = data['name'] as String;
        final String userEmail = data['email'] as String;
        final String userPhone = data['phone'] as String;
        final String userUid = data['uid'] as String;
        final String Title = data['title'] as String;


        name = userName;
        id = userUid;
        email = userEmail;
        phone = userPhone;
        title = Title;
        uid = userUid;

        emit(GetUserInfoSuccess());
      }
    } on Exception catch (e) {
      emit(GetUserInfoFailed());
      print(e.toString());
    }
  }

  void updateUserInfo(String valueName, String newValue) async {
    emit(UpdateUserInfoLoading());
    try {
      DocumentReference userRef = database.collection('Users').doc(id);

      await userRef.update({valueName: newValue});
      if (valueName == 'name') {
        name = newValue;
      } else if (valueName == 'title') {
        title = newValue;
      } else if (valueName == 'email') {
        email = newValue;
      } else if (valueName == 'phone') {
        phone = newValue;
      }
      emit(UpdateUserInfoSuccess());
    } catch (e) {
      emit(UpdateUserInfoFailed());
      print(e.toString());
    }
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<void> showCalendar(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      year = selectedDate!.year;
      month = selectedDate!.month;
      day = selectedDate!.day;
    }
    emit(DatePickedSuccessfully());
  }

  Future<UserCredential> Register(
      {required String email,
      required String password,
      required String name,
      required String phone,
      String? image,
      required String title}) async {
    try {
      emit(RegisterLoading());
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      database.collection('Users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid,
        'title': title,
        'phone': phone,
      });
      emit(RegisterSuccess());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailed());
      print(e.message);
      rethrow;
    }
  }

  Future<UserCredential> Login(
      {required String email, required String password}) async {
    try {
      emit(LoginLoading());

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      emit(LoginSuccess());
      getUserInfo(user!.uid);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(LoginFailed());
      print(e.message);
      rethrow;
    }
  }

  Stream<QuerySnapshot> getTasksStream(String UserId, otherUserId) {
    List<String> ids = [UserId, otherUserId];

    ids.sort();
    String taskRoomId = ids.join('_');

    return database
        .collection('tasks_rooms')
        .doc(taskRoomId)
        .collection('tasks')
        .snapshots();
  }

  // Stream<QuerySnapshot> getUserInfoStream(String UserId, otherUserId) {
  //   List<String> ids = [ UserId , otherUserId];
  //
  //
  //   ids.sort();
  //   String taskRoomId = ids.join('_');
  //
  //   return database
  //       .collection('tasks_rooms')
  //       .doc(taskRoomId)
  //       .collection('tasks')
  //       .snapshots();
  // }

  Future<void> sendTask({
    required String receiverID,
    required String senderID,
    required String title,
    required String description,
    required String deadline,
    required String senderName,
    required String senderPhone,
    required String taskName,
    required String taskId,
    required String status,
    required String priority,
  }) async {
    emit(SendTaskLoading());
    final String currentUserId = auth.currentUser!.uid;
    final String email = auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();
    Tasks tasks = Tasks(
        name: taskName,
        id: taskId,
        senderId: senderID,
        senderEmail: email,
        senderName: senderName,
        senderPhoneNumber: senderPhone,
        receiverId: receiverID,
        description:  description,
        date:     timeStamp.toString(),
        deadline: deadline,
        status:   status,
        priority: priority);

    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String taskRoomId = ids.join('_');
    await database
        .collection("tasks_rooms")
        .doc(taskRoomId)
        .collection('tasks')
        .add(tasks.task())
        .then((value) {
      tasksList.add(value);
      print('task name is${tasks.name}');
      emit(SendTaskSuccess());
    }).catchError((onError) {
      emit(SendTaskFailed());
      print('error');
      print(onError.toString());
    });
  }





  List<Widget> pagesNames = [
    const HomeScreen(
      receiverId: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2',
    ),
    CalenderScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

}

