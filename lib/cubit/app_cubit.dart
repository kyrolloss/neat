import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/Calender%20Screen/Calender%20Screen.dart';
import 'package:neat/Screens/Home/home.dart';
import 'package:neat/Screens/Notification/Notification.dart';
import 'package:neat/Screens/Profile/Profile%20Screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  DateTime? selectedDate = DateTime.tryParse('yyyy-MM-dd');
  int? year;
  int? month;
  int? day;

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

  var auth = FirebaseAuth.instance;
  var database = FirebaseFirestore.instance;
  var storge = FirebaseStorage.instance;
  var user = FirebaseAuth.instance.currentUser;

  Future<UserCredential> Register(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String gender,
      required String image,
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
        'url': image,
        'phone': phone,
        'gender': gender,
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
      // database.collection('Users').doc(userCredential.user!.uid).set({
      //   'email': userCredential.user!.email,
      //   'uid': userCredential.user!.uid,
      //
      // });

      emit(LoginSuccess());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(LoginFailed());
      print(e.message);
      rethrow;
    }
  }

  List<Widget> pagesNames = [
    const HomeScreen(),
    CalenderScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
}
