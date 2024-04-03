import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';

import '../../../Screens/Task Details Screen/Task Details Screen.dart';
import '../../../components/components.dart';
import '../../../cubit/app_cubit.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BuildText(
          text: 'Completed Tasks',
          color: Colors.white,
          size: 17.5,
          letterSpacing: 1.5,


        ),
        backgroundColor: AppColor.primeColor,
        centerTitle: true,

          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:  Icon(Icons.arrow_back_ios , color: AppColor.secondColor,))


      )
      ,
      body: BuilderTasksList(),
    );
  }

  Widget BuilderTasksList() {
    return StreamBuilder(
      stream: AppCubit.get(context).performanceStream(),
      builder: (context, snapshot) {

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
        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 1.5),
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

    return GestureDetector(
      onTap: () async {
        navigateTo(
            context,
            taskDetailsScreen(
              name: taskData['name'],
              description: taskData['description'],
              day: taskData['day'],
              year: taskData['year'],
              month: taskData['month'],
              senderID: taskData['senderId'],
              senderName: taskData['senderName'],
              senderEmail: taskData['senderEmail'],
              senderPhone: taskData['senderPhoneNumber'],
              taskId: taskData['id'],
            ));
      },
      child: taskData ['status'] == 'completed' ?Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 12, left: 12),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width * .2,
            minWidth: width * .05,
          ),
          child: Container(
            height: height * .1,
            decoration: BoxDecoration(
                color: AppColor.secondColor,
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.note_sharp,
                  color: AppColor.primeColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: width * .2,
                        child: BuildText(
                          text: taskData['name'],
                          size: 17.5,
                          bold: true,
                          color: AppColor.primeColor,
                          maxLines: 2,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ): Center(
        child: BuildText(
          text: 'No Tasks sent',
          size: 25,
          color : AppColor.primeColor,
          bold: true,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
