import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkblob_navigation_bar/inkblob_navigation_bar.dart';
import 'package:neat/Screens/Home/home.dart';
import 'package:neat/components/color.dart';
import 'package:neat/cubit/app_cubit.dart';


class MainLayout extends StatefulWidget {
  int buttomIndex = 0;
  final String uid;
  Widget? widget;

  MainLayout({super.key, required this.uid}) {
    widget = HomeScreen(receiverId: uid);
  }

  @override
  State<MainLayout> createState() => _MainLayoutState();

}

class _MainLayoutState extends State<MainLayout> {





  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          bottomNavigationBar: InkblobNavigationBar(
            selectedIndex: 1,
            iconSize: 35,
            items: [
              InkblobBarItem(
                  emptyIcon:  Icon(Icons.home , color: AppColor.primeColor,),
                  filledIcon:  Icon(Icons.home_outlined, color: AppColor.primeColor,)),
              InkblobBarItem(
                  emptyIcon:  Icon(Icons.calendar_month, color: AppColor.primeColor,),
                  filledIcon:  Icon(Icons.calendar_month_outlined, color: AppColor.primeColor,)),
              InkblobBarItem(
                  emptyIcon:  Icon(Icons.notifications, color: AppColor.primeColor,),
                  filledIcon:  Icon(Icons.notifications_none, color: AppColor.primeColor,)),
              InkblobBarItem(
                  emptyIcon:  Icon(Icons.person, color: AppColor.primeColor,),
                  filledIcon:  Icon(Icons.person_outline, color: AppColor.primeColor,)),


            ],
            onItemSelected: (int value) {
              setState(() {
                widget.buttomIndex = value;
                widget.widget = cubit.pagesNames[widget.buttomIndex];
              });
            },
          ),
          body: widget.widget,
        );
      },
    );
  }
}
