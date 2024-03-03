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





  List<Widget> pagesNames = [
    const HomeScreen(),
     CalenderScreen(),
    const NotificationScreen(),
    const ProfileScreen(),

  ];

}
