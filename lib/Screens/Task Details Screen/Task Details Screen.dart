import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:neat/components/color.dart';

import '../../Models/task Model.dart';
import '../../components/Text.dart';

class taskDetailsScreen extends StatefulWidget {
  String name;
  String description;
  String deadline;
  String status;
  String SenderID;
  String SenderName;
  String SenderEmail;
  String SenderPhone;
  String SenderImage;
  String TaskID;
  String attachments;

  taskDetailsScreen(
      {super.key,
      required this.name,
      required this.description,
      required this.deadline,
      required this.status,
      required this.SenderID,
      required this.SenderName,
      required this.SenderEmail,
      required this.SenderPhone,
      required this.SenderImage,
      required this.TaskID,
      required this.attachments});

  @override
  State<taskDetailsScreen> createState() => _taskDetailsScreenState();
}

class _taskDetailsScreenState extends State<taskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: BuildText(
                    text: 'Task name',
                    bold: true,
                    color: AppColor.primeColor,
                    size: 35,
                    center: true,
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                SizedBox(
                  child: BuildText(
                    text: 'Task Description',
                    bold: true,
                    color: AppColor.primeColor.withOpacity(.7),
                    size: 20,
                    center: true,
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      BuildText(
                        maxLines: 100,
                        text: '''
UI Design:
Develop visually appealing UI designs for various screens of the gaming application, including home screens, game menus, settings pages, and in-game interfaces.
UX Enhancement:
Analyze user feedback and gaming trends to identify areas for UX improvement.
Streamline user flows, optimize navigation paths, and enhance overall usability to increase user engagement.
Wireframing and Prototyping:
Create wireframes and interactive prototypes to visualize design concepts and gather feedback from stakeholders.
Iterate on designs based on feedback and usability testing results.
Graphic Assets Production:
Produce high-quality graphic assets such as icons, buttons, illustrations, and animations to complement the UI design.
                              ''',
                        bold: true,
                        color: Colors.black,
                        size: 17.5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BuildText(
                        text: 'Attachment',
                        bold: true,
                        color: AppColor.primeColor.withOpacity(.7),
                        size: 20,
                        center: true,
                      ),
                      Container(
                        height: height * .05,
                        width: width * .1,
                        decoration: BoxDecoration(
                          color: AppColor.primeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.attachment),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
