import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';

import '../../../Screens/Task Details Screen/Task Details Screen.dart';
import '../../../Screens/chat/chat_screen.dart';
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
              taskId: taskData['id'], sender: true,
            ));
      },
      child: taskData ['status'] == 'completed' ?
      Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 12, left: 12),
        child: Container(
          height: height * .1,
          decoration: BoxDecoration(
              color: AppColor.secondColor,
              borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 12.0, top: 8, bottom: 8, left:17.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildText(
                      text: taskData['name'],
                      size: 16,
                      bold: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${taskData['year']}/${taskData['month']}/${taskData['day']}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      taskData['priority'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .where('uid', isEqualTo: taskData['receiverId'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        navigateTo(context, ChatScreen(
                          receiverUserEmail: snapshot.data!.docs[0]['email'],
                          receiverUserID: snapshot.data!.docs[0]['uid'],));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            color: AppColor.primeColor,
                          ),
                          Text('Chat with',
                              style: TextStyle(
                                color: AppColor.primeColor,
                                fontSize: 12,
                              )),
                          SizedBox(
                            height: height * .025,
                            width: width * .3,
                            child: Center(
                              child: Text(
                                snapshot.data!.docs[0]['name'],
                                style: TextStyle(
                                  color: AppColor.primeColor,
                                  fontSize: 12,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
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
