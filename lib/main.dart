import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/Calender%20Screen/Calender%20Screen.dart';
import 'package:neat/Screens/Task%20template%20Screen.dart';
import 'package:neat/cubit/app_cubit.dart';

import 'Screens/MainLayout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TaskTemplateScreen(

          )),
    );
  }
}
