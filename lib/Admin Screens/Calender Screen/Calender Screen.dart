import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Admin%20Screens/Calender%20Screen/to%20do%20tab/to%20do%20tap.dart';
import 'package:neat/components/color.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../calender/calender.dart';
import '../../cubit/app_cubit.dart';
import 'completed tab/completed tab.dart';
import 'in Progress tab/in Progress tab.dart';

class adminCalenderScreen extends StatefulWidget {
  final String uid;

  const adminCalenderScreen({Key? key, required this.uid});

  @override
  State<adminCalenderScreen> createState() => _adminCalenderScreen();
}

class _adminCalenderScreen extends State<adminCalenderScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  DateTime? _focusDate = DateTime.now();

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
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EasyDateTimeLine(
                      initialDate: DateTime.now(),
                      activeColor: AppColor.primeColor,
                      onDateChange:  (selectedDate) {
                        setState(() {
                          setState(()  {
                            cubit.tasksCalendar.clear();
                            _focusDate = selectedDate;
                            cubit.getAdminTasksInCalender(selectedDate.day,
                                selectedDate.month, selectedDate.year);

                          });
                        });
                         print('selectedDate:$selectedDate');
                         print('focusDate:$_focusDate');
                         print('year:${selectedDate.year}');
                         print('month:${selectedDate.month}');
                         print('day:${selectedDate.day}');
                      },
                    ),




                    // EasyInfiniteDateTimeLine(
                    //
                    //   controller: _controller,
                    //   firstDate: DateTime(2024),
                    //   focusDate: _focusDate,
                    //   lastDate: DateTime(2024, 12, 31),
                    //   onDateChange: (selectedDate) async{
                    //     setState(()  {
                    //       cubit.tasksCalendar.clear();
                    //       _focusDate = selectedDate;
                    //
                    //       cubit.getAdminTasksInCalender(selectedDate.day,
                    //           selectedDate.month, selectedDate.year);
                    //
                    //     });
                    //   },
                    //   activeColor: AppColor.primeColor,
                    //
                    //
                    // )
                    SizedBox(
                      height: height * .02,
                    ),
                    TabBar(
                        indicatorColor: Colors.red,
                        indicatorWeight: 1,
                        splashBorderRadius: BorderRadius.circular(20),
                        dividerHeight: 0,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: -25),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColor.primeColor,
                        ),
                        unselectedLabelColor: AppColor.primeColor,
                        unselectedLabelStyle: const TextStyle(
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
                      child: TabBarView(controller: controller, children: [
                        admintoDoTab(
                          tasks: cubit.tasksCalendar,
                        ),
                        admininProgress(
                          tasks: cubit.tasksCalendar,
                        ),
                        admincompletedTab(
                          tasks: cubit.tasksCalendar,
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
