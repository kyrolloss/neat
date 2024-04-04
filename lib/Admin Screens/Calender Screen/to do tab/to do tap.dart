import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neat/Screens/Task%20Details%20Screen/Task%20Details%20Screen.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/components/components.dart';

import '../../../cubit/app_cubit.dart';

class admintoDoTab extends StatefulWidget {
  final String receiverId;

  const admintoDoTab({super.key, required this.receiverId});

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

    return BuilderToDoTasksList(
    );
  }
  Widget BuilderToDoTasksList() {

    return StreamBuilder(
      stream: AppCubit.get(context).getTasksStream(),
      builder: (context, snapshot) {
        AppCubit.get(context).getTasksStream( ).listen((event) {
          AppCubit.get(context).numberOfTodoTasks=event.docs.length;
        });
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState) {
          return const Text('Loading');
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            color: AppColor.primeColor,
          );
        }
        return ListView(



          children:
          snapshot.data!.docs.map((doc) => BuildtaskListItem(doc)).toList(),
        );
      },
    );
  }

  Widget BuildtaskListItem(DocumentSnapshot doc) {
    Map<String, dynamic> taskData = doc.data() as Map<String, dynamic>;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return taskData['status'] =='to do'? Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          navigateTo(context, taskDetailsScreen(
            name: taskData['name'],
            description: taskData['description'],
            day: taskData['day'],
            month: taskData['month'],
            year: taskData['year'],

            // status: taskData['status'],
            senderID: taskData['senderId'],
            senderName: taskData['senderName'],
            senderEmail: taskData['senderEmail'],
            senderPhone: taskData['senderPhoneNumber'],
            taskId: taskData['id'],
            sender: true,

          ));
        },
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
                  text:taskData['name'],
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
                      text:'deadline is ${ taskData['deadline']}',
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
      ),
    ): const SizedBox();
  }
}
