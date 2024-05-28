import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neat/Screens/Task%20Details%20Screen/Task%20Details%20Screen.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/components/components.dart';

import '../../../Models/task Model.dart';
import '../../../cubit/app_cubit.dart';

class admintoDoTab extends StatefulWidget {
  final List<Tasks> tasks;

  const admintoDoTab({super.key, required this.tasks, });

  @override
  State<admintoDoTab> createState() => _admintoDoTab();
}

class _admintoDoTab extends State<admintoDoTab> {
  Color box1Color = Colors.blue;
  Color box2Color = Colors.blue;
  Color box3Color = Colors.blue;
  void _toggleBoxColor(int boxNumber) {
    setState(() {
      if (boxNumber == 1) {
        box1Color = Colors.blue;
        box2Color = Colors.blue;
        box3Color = Colors.blue;
      } else if (boxNumber == 2) {
        box1Color = Colors.grey;
        box2Color = Colors.yellow;
        box3Color = Colors.grey;
      } else if (boxNumber == 3) {
        box1Color = Colors.grey;
        box2Color = Colors.grey;
        box3Color = Colors.green;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return widget.tasks[index].status == 'to do'
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height * .125,
            width: width * .8,
            decoration: BoxDecoration(
              color: AppColor.secondColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildText(
                    text: widget.tasks[index].name,
                    color: AppColor.primeColor,
                    size: 20,
                    bold: true,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: AppColor.primeColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      BuildText(
                        text:
                        'deadline is ${widget.tasks[index].year} ${widget.tasks[index].month} ${widget.tasks[index].day}',
                        color: AppColor.primeColor,
                        size: 15,
                        bold: true,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
            : const SizedBox();
      },
    );
  }

}
