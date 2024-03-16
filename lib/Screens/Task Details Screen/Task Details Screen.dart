import 'package:flutter/material.dart';
import 'package:neat/components/color.dart';

import '../../components/Text.dart';

class taskDetailsScreen extends StatefulWidget {
  // String? senderID;
  String? description;

  // String? deadline;
  // String? senderName;
  // String? senderPhone;
  // String? taskId;
  // String? status;
  String? name;

  // // String? priority;
  // String? senderEmail;
  // String? imageURl;
  // dynamic attachments;

  taskDetailsScreen({
    //  this.senderID,
    this.description,
    //  this.deadline,
    //  this.senderName,
    //  this.senderPhone,
    //  this.taskId,
    //  this.status,
    this.name,
    //  // this.priority,
    //  this.senderEmail,
    // this.imageURl,
    // // this.attachments,
  });

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: BuildText(
                      text: widget.name!,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildText(
                          maxLines: 100,
                          text: widget.description!,
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
                          height: height * .075,
                          width: width * .2,
                          decoration: BoxDecoration(
                            color: AppColor.primeColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.attachment),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                              BuildText(
                                text: 'Download',
                                size: 10,
                                color: Colors.white,
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // widget.imageURl == null
                  //      SizedBox(
                  //         height: height * .2,
                  //         width: width * .875,
                  //         child: const Image(image: NetworkImage('widget.imageURl!')),
                  //       )
                  // :  BuildText(
                  //     text: 'No attachment',
                  //     size: 15,
                  //     color: AppColor.primeColor,
                  //     bold: true,
                  //   )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
