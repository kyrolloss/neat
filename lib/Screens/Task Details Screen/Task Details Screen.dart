import 'dart:ffi';

import 'dart:ffi';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:neat/components/color.dart';

import '../../components/Text.dart';

class taskDetailsScreen extends StatefulWidget {
  String? senderID;
  String? description;
  Int? year;
  Int? month;
  Int? day;
  String? senderName;
  String? senderPhone;
  String? taskId;
  String? status;
  String? name;

  // // String? priority;
  String? senderEmail;

  // String? imageURl;
  // dynamic attachments;

  taskDetailsScreen({
    this.senderID,
    this.description,
    this.senderName,
    this.senderPhone,
    this.taskId,
    this.year,
    this.month,
    this.day,
    //  this.status,
    this.name,
    //  // this.priority,
    this.senderEmail,
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
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: BuildText(
                        text: widget.name!,
                        bold: true,
                        color: AppColor.primeColor,
                        size: 35,
                        center: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Container(
                      height: height * .4,
                      width: width,
                      decoration: BoxDecoration(
                          color: AppColor.primeColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                BuildText(
                                  text: 'Sender Name : ',
                                  color: Colors.white,
                                  size: 17.5,
                                  bold: true,
                                ),
                                BuildText(
                                    text: widget.senderName!,
                                    color: Colors.white,
                                    size: 17.5,
                                    bold: true)
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BuildText(
                                  text: 'Sender Id : ',
                                  color: Colors.white,
                                  size: 17.5,
                                  bold: true,
                                ),
                                SizedBox(
                                    width: width * .5,
                                    height: height * .1,
                                    child: Center(
                                      child: BuildText(
                                          maxLines: 2,
                                          text: widget.senderID!,
                                          color: Colors.white,
                                          size: 17.5,
                                          bold: true),
                                    )),
                                Center(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                BuildText(
                                  text: 'Sender phone : ',
                                  color: Colors.white,
                                  size: 17.5,
                                  bold: true,
                                ),
                                BuildText(
                                    text: widget.senderPhone!,
                                    color: Colors.white,
                                    size: 17.5,
                                    bold: true),
                                Center(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                BuildText(
                                  text: 'Sender Email : ',
                                  color: Colors.white,
                                  size: 17.5,
                                  bold: true,
                                ),
                                BuildText(
                                    text: widget.senderEmail!,
                                    color: Colors.white,
                                    size: 17.5,
                                    bold: true),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                BuildText(
                                  text: 'Task ID :  ',
                                  color: Colors.white,
                                  size: 17.5,
                                  bold: true,
                                ),
                                SizedBox(
                                    height: height * .075,
                                    width: width * .5,
                                    child: Center(
                                      child: BuildText(
                                          maxLines: 3,
                                          text: widget.taskId!,
                                          color: Colors.white,
                                          size: 17.5,
                                          bold: true),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: height * .01,
                  ),
                  BuildText(
                    text: 'Task Description',
                    bold: true,
                    color: AppColor.primeColor.withOpacity(.7),
                    size: 20,
                    center: true,
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
                  SizedBox(
                    height: height * .02,
                  ),
                  Row(
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
                        height: height * .07,
                        width: width * .155,
                        decoration: BoxDecoration(
                          color: AppColor.primeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.attachment,
                              size: 25,
                              color: Colors.white,
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
                  SizedBox(
                    height: height * .02,
                  ),
                  Row(
                    children: [
                      BuildText(
                        text: 'Deadline : ',
                        bold: true,
                        color: AppColor.primeColor.withOpacity(.7),
                        size: 20,
                        center: true,
                      ),
                      BuildText(
                        text: '${widget.year}+${widget.month}+${widget.day}',
                        bold: true,
                        color: Colors.black,
                        size: 20,
                        center: true,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * .075,
                          width: width * .75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColor.primeColor,
                          ),
                          child: Center(
                            child: BuildText(
                              text: 'Send Task',
                              color: Colors.white,
                              bold: true,
                              size: 25,
                            ),
                          ),
                        ),
                        Container(
                          height: height * .075,
                          width: width * .15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.send,
                                  size: 25,
                                  color: AppColor.primeColor,
                                ),
                                BuildText(
                                  text: 'Chat',
                                  size: 12.5,
                                  color: AppColor.primeColor,
                                  bold: true,
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
