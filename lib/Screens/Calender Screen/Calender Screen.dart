import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/Calender%20Screen/completed%20tab/completed%20tab.dart';
import 'package:neat/Screens/Calender%20Screen/in%20Progress%20tab/in%20Progress%20tab.dart';
import 'package:neat/Screens/Calender%20Screen/to%20do%20tab/to%20do%20tap.dart';
import 'package:neat/components/color.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../calender/calender.dart';
import '../../cubit/app_cubit.dart';
import '../../utlis/constants/colors.dart';

class CalenderScreen extends StatefulWidget {

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen>
    with SingleTickerProviderStateMixin {

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    var height = MediaQuery.of(context).size.height;

    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit= AppCubit.get(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              changeTodyHighlightColorExample(),
              SizedBox(
                height: height * .02,
              ),
              TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 1,
                  splashBorderRadius: BorderRadius.circular(20),
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: -25),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.primeColor,
                  ),
                  unselectedLabelColor: AppColor.primeColor,
                  unselectedLabelStyle: const  TextStyle(
                      decorationStyle: TextDecorationStyle.wavy,
                      fontWeight: FontWeight.bold),
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  labelColor: AppColor.secondColor,
                  controller: controller,
                  tabs: const [
                    Tab(
                      text: 'To Do',
                    ),
                    Tab(
                      text: 'In Progress',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                  ]),

              SizedBox(
                height: height * .002,
              ),
              SizedBox(
                height: height * .8,
                child: TabBarView(

                  controller: controller,
                    children:  const [
                      toDoTab(receiverId: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2'),
                      inProgress(receiverId: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2'),
                      completedTab(receiverId: 'aiQxoxrg5zPLIQ7NniWdyUFnwmF2')

                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
