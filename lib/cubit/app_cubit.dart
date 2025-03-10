import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:neat/Admin%20Screens/Calender%20Screen/Calender%20Screen.dart';
import 'package:neat/Models/task%20Model.dart';
import 'package:neat/Admin%20Screens/Task%20template%20Screen.dart';
import 'package:neat/Screens/Profile/profile_screen.dart';
import 'package:neat/components/color.dart';

import '../Admin Screens/Home/home Screen.dart';
import '../Admin Screens/Main Layout.dart';
import '../Admin Screens/Profile/profile_screen.dart';
import '../Admin Screens/notification/notification Screen.dart';
import '../Screens/Calender Screen/Calender Screen.dart';
import '../Screens/Home/home.dart';
import '../Screens/MainLayout.dart';
import '../Screens/Notification/Notification.dart';
import '../Screens/Profile/performance/performance.dart';
import '../components/components.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  DateTime? selectedDate = DateTime.tryParse('yyyy-MM-dd');

  bool premium = false;
  int year = 0;
  int month = 0;
  int day = 0;
  List tasksList = [];
  int numberOfTodoTasks = 0;
  int numberOfInProgressTasks = 0;
  int numberOfCompletedTasks = 0;
  int membersUnderSupervision = 0;
  String id = '';
  String name = '';
  String email = '';
  String phone = '';
  String title = '';
  String? url;

  String typee = '';

  var database = FirebaseFirestore.instance;
  var storge = FirebaseStorage.instance;
  var user = FirebaseAuth.instance.currentUser;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final CollectionReference tasksRoomsCollection =
      FirebaseFirestore.instance.collection('tasks_rooms');
  var auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<void> updateInfo(
      {required String id,
      required String name,
      required String email,
      required String phone,
      required String title,
      required String? url,
      required String typee,
      required String NewId,
      required String Newname,
      required String Newemail,
      required String Newphone,
      required String Newtitle,
      required String? Newurl,
      required String Newtypee}) async {
    name = typee;
    id = NewId;
    email = Newname;
    phone = Newemail;
    title = Newphone;
    url = Newtitle;
    typee = Newurl!;
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
        String? image = data['url'] ?? '';
        String? type = data['type'] ?? '';

        name = userName;
        id = userUid;
        email = userEmail;
        phone = userPhone;
        title = Title;
        url = image!;
        typee = type!;

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

  Future<void> showCalendar(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      cancelText: 'cancel',
      confirmText: 'confirm',
      helpText: 'select date',
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primeColor,
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate = picked;
      year = selectedDate!.year;
      month = selectedDate!.month;
      day = selectedDate!.day;

      emit(DatePickedSuccessfully());
    }
  }

  Future<UserCredential> Register(
      {required String email,
      required String password,
      required String name,
      required String phone,
      String? image,
      required String title,
      required String type ,
      required bool premium}) async {
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
        'url': image ?? '',
        'type': type,
        'premium': premium
      });
      getUserInfo(userCredential.user!.uid);
      emit(RegisterSuccess());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailed());
      print(e.message);
      rethrow;
    }
  }


  Future<UserCredential> Login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      emit(LoginLoading());

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await getUserInfo(userCredential.user!.uid);

      emit(LoginSuccess());

      if (typee == 'Admin') {
        navigateToToFinish(
            context, AdminMainLayout(uid: userCredential.user!.uid));
      } else if (typee == 'User') {
        navigateTo(context, MainLayout(uid: userCredential.user!.uid));
      }
      emit(NavigationDone());

      print(id);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(LoginFailed());
      print(e.message);
      rethrow;
    }
  }

  Future<void> sendTask({
    required String receiverID,
    required String senderID,
    required String title,
    required String description,
    required String senderName,
    required String senderPhone,
    required String taskName,
    required String taskId,
    required String status,
    required String priority,
    required int day,
    required int month,
    required int year,
     String? url
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
      description: description,
      date: timeStamp.toString(),
      status: status,
      priority: priority,
      day: day,
      year: year,
      month: month,
      dayCompleted: 0,
      monthCompleted: 0,
      yearCompleted: 0,
     image: url
    );

    await database
        .collection("tasks_rooms")
        .doc('taskRoomId')
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

  List<Tasks> tasksCalendar = [];
  List<Tasks> taskss = [];

  Future<void> getTasksInCalender(int day, int month, int year) async {
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance
            .collection('tasks_rooms')
            .doc('taskRoomId')
            .collection('tasks')
            .where('receiverId', isEqualTo: id)
            .snapshots();
    emit(GetCalenderTasks());

    notificationStream.listen((snapshot) {
      List<Tasks> tasks = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        Tasks task = Tasks.fromJson(data);

        if (task.year == year && task.month == month && task.day == day) {
          tasks.add(task);
          emit(AddToCalenderTasksList());
        }
      }

      tasksCalendar = tasks;
    emit(EqualityBetweenTheTwoLists());
  });
}

double competedTask = 0;
double toDoTask = 0;

Future<void> getPerformanceTask({required String ID}) async {
  Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
  FirebaseFirestore.instance
      .collection('tasks_rooms')
      .doc('taskRoomId')
      .collection('tasks')
      .where('receiverId', isEqualTo: ID)
      .snapshots();
  emit(GetCalenderTasks());

    notificationStream.listen((snapshot) {
      List<Tasks> tasks = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        Tasks task = Tasks.fromJson(data);
        if (data['yearCompleted'] != 0 &&
            data['monthCompleted'] != 0 &&
            data['dayCompleted'] != 0) {
          tasks.add(task);
        }
      }
      taskss = tasks;
      print('taskss  is $taskss');
      emit(EqualityBetweenTheTwoLists());
    });
  }

  Future<void> getPerformance({required BuildContext context}) async {
    try {
      await getPerformanceTask(ID: id);
      emit(GetPerformanceLoading());
      Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
          FirebaseFirestore.instance
              .collection('tasks_rooms')
              .doc('taskRoomId')
              .collection('tasks')
              .where('receiverId', isEqualTo: id)
              .snapshots();
      emit(GetCalenderTasks());

      notificationStream.listen((snapshot) {
        competedTask = 0;
        toDoTask = 0;


        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();
          if (data['yearCompleted'] != 0 &&
              data['monthCompleted'] != 0 &&
              data['dayCompleted'] != 0) {
            if (data['yearCompleted'] == data['year']) {
              if (data['monthCompleted'] < data['month']) {
                competedTask++;

              } else if (data['monthCompleted'] == data['month'] &&
                  data['dayCompleted'] <= data['day'])
              {
                {
                  competedTask++;
                }
              } else {
                toDoTask++;
              }
            } else {
              toDoTask++;
            }
          }


          print('toDoTask is $toDoTask');
          print('competedTask is $competedTask');
        }
      });

      Future.delayed(const Duration(seconds: 1), () {
        navigateTo(context,  PerformanceScreen(toDoTask: toDoTask, completeTask: competedTask, tasksList: taskss,));
      });      emit(GetPerformanceSuccess());
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }

  Future<void> adminGetPerformance({required BuildContext context , required String receiverId}) async {
    try {
      await getPerformanceTask(ID: receiverId);
      emit(GetPerformanceLoading());
      Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
      FirebaseFirestore.instance
          .collection('tasks_rooms')
          .doc('taskRoomId')
          .collection('tasks')
          .where('receiverId', isEqualTo: receiverId)
          .snapshots();
      emit(GetCalenderTasks());

      notificationStream.listen((snapshot) {
        competedTask = 0;
        toDoTask = 0;


        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();
          if (data['yearCompleted'] != 0 &&
              data['monthCompleted'] != 0 &&
              data['dayCompleted'] != 0) {
            if (data['yearCompleted'] == data['year']) {
              if (data['monthCompleted'] < data['month']) {
                competedTask++;

              } else if (data['monthCompleted'] == data['month'] &&
                  data['dayCompleted'] <= data['day'])
              {
                {
                  competedTask++;
                }
              } else {
                toDoTask++;
              }
            } else {
              toDoTask++;
            }
          }


          print('toDoTask is $toDoTask');
          print('competedTask is $competedTask');
        }
      });
      Future.delayed(const Duration(seconds: 1), () {
        navigateTo(context,  PerformanceScreen(toDoTask: toDoTask, completeTask: competedTask, tasksList: taskss,));
      });

      emit(GetPerformanceSuccess());

    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }


  Future<void> getAdminTasksInCalender(int day, int month, int year) async {
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance
            .collection('tasks_rooms')
            .doc('taskRoomId')
            .collection('tasks')
            .where('senderId', isEqualTo: id)
            .snapshots();
    emit(GetCalenderTasks());

    notificationStream.listen((snapshot) {
      List<Tasks> tasks = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        Tasks task = Tasks.fromJson(data);

        if (task.year == year && task.month == month && task.day == day) {
          tasks.add(task);
          emit(AddToCalenderTasksList());
        }
      }

      tasksCalendar = tasks;
      emit(EqualityBetweenTheTwoLists());
    });
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String channelId = 'your_channel_id';

  showNotification({required String title, required String body}) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, 'Notify my',
            importance: Importance.high);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: null,
        macOS: null,
        linux: null);

    flutterLocalNotificationsPlugin.show(01, title, body, notificationDetails);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
      FirebaseFirestore.instance.collection('tasks_rooms').snapshots();

  // chat

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveData({
    required Uint8List file,
  }) async {
    emit(AddDataLoading());

    try {
      String imageUrl = await uploadImageToStorage('profileImage', file);
      await database.collection('Users').add({
        'image link': imageUrl,
      });
      emit(AddDataSuccess());
    } catch (err) {
      print(err.toString());
      emit(AddDataFailed());
    }
  }

  void addMemberToGroup(String memberId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('uid', isEqualTo: memberId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          querySnapshot.docs.first;
      Map<String, dynamic>? userData = userDocument.data();

      CollectionReference groupsCollection = FirebaseFirestore.instance
          .collection('groups')
          .doc(id)
          .collection('members');

      await groupsCollection.doc(memberId).set(userData);

      print('Group document created: ${groupsCollection.doc(memberId)}');
    } else {
      print('No user found with the specified memberId');
    }
  }

  void addMemberToGroupByEmail(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          querySnapshot.docs.first;
      Map<String, dynamic>? userData = userDocument.data();

      CollectionReference groupsCollection =
          FirebaseFirestore.instance.collection('groups');

      await groupsCollection.doc(id).set(userData);

      print('Group document created: ${groupsCollection.doc(email)}');
    } else {
      print('No user found with the specified memberId');
    }
  }

  Stream<List<Map<String, dynamic>>> getTeamStream() {
    return database
        .collection('groups')
        .doc(id)
        .collection('members')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        /// go through each individual user
        final user = doc.data();

        /// return user
        return user;
      }).toList();
    });
  }

  Stream<QuerySnapshot> getTasksStream() {
    return database
        .collection('tasks_rooms')
        .doc('taskRoomId')
        .collection('tasks')
        .where('receiverId', isEqualTo: id)
        .snapshots();
  }

  Stream<QuerySnapshot> getAdminTasksStream() {
    return database
        .collection('tasks_rooms')
        .doc('taskRoomId')
        .collection('tasks')
        .where('senderId', isEqualTo: id)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> performanceStream() {
    return database
        .collection('tasks_rooms')
        .doc('taskRoomId')
        .collection('tasks')
        .where('senderId', isEqualTo: id)
        .snapshots();
  }

  List<Widget> pagesNames = const [
    HomeScreen(
      receiverId: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2',
    ),
    CalenderScreen(
      uid: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2',
    ),
    NotificationScreen(
      uid: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2',
    ),
    ProfileScreen()
  ];

  List<Widget> adminPagesNames = const [
    adminHomeScreen(),
    adminCalenderScreen(),
    TaskTemplateScreen(),
    adminNotificationScreen(
      uid: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2',
    ),
    AdminProfileScreen(
      uid: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2',
    ),
  ];
}
