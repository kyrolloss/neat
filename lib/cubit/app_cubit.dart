import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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


  List<Widget> pagesNames = [
    const HomeScreen(),
     CalenderScreen(),
    const NotificationScreen(),
    const ProfileScreen(),

  ];

}
