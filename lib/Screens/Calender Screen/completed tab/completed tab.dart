import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';

import '../../../components/components.dart';
import '../../../cubit/app_cubit.dart';
import '../../Task Details Screen/Task Details Screen.dart';

class completedTab extends StatefulWidget {
  final String receiverId;

  const completedTab({super.key, required this.receiverId});

  @override
  State<completedTab> createState() => _toDoTabState();
}

class _toDoTabState extends State<completedTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BuilderInProgressTasksList(
    );
  }
  Widget BuilderInProgressTasksList() {


    return StreamBuilder(
      stream: AppCubit.get(context).getTasksStream( ),
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


    return taskData['status'] =='completed'? Padding(
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
