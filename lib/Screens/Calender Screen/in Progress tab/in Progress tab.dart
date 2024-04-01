import 'package:flutter/material.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';

import '../../../../Models/task Model.dart';


class inProgress extends StatefulWidget {
  final String receiverId;
  final List<Tasks> tasks;

  const inProgress({super.key, required this.receiverId, required this.tasks});

  @override
  State<inProgress> createState() => _toDoTabState();
}

class _toDoTabState extends State<inProgress> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return widget.tasks[index].status == 'inProgress'
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