import 'package:flutter/material.dart';
import 'package:neat/components/color.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../components/Text.dart';

class taskDetailsScreen extends StatefulWidget {
  String? senderID;
  String? description;
  int year;
  int month;
  int day;
  String? senderName;
  String? senderPhone;
  String? taskId;
  String? status;
  String? name;

  // // String? priority;
  String? senderEmail;
  bool? sender = false;

  // String? imageURl;
  // dynamic attachments;

  taskDetailsScreen({
    this.senderID,
    this.description,
    this.senderName,
    this.senderPhone,
    this.taskId,
    required this.year,
    required this.month,
    required this.day,
    //  this.status,
    this.name,
    //  // this.priority,
    this.senderEmail,
    this.sender,
    // this.imageURl,
    // this.attachments,
    // this.imageURl,
    // // this.attachments,
  });

  @override
  State<taskDetailsScreen> createState() => _taskDetailsScreenState();
}

class _taskDetailsScreenState extends State<taskDetailsScreen> {
  double _value = 40.0;

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
                        size: 25,
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
                                  letterSpacing: 1.5,
                                ),
                                BuildText(
                                  text: widget.senderName!,
                                  color: Colors.white,
                                  size: 17.5,
                                  letterSpacing: 1.5,
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BuildText(
                                  text: 'Sender Id : ',
                                  color: Colors.white,
                                  size: 15,
                                  letterSpacing: 1.5,
                                ),
                                SizedBox(
                                    width: width * .5,
                                    height: height * .1,
                                    child: Center(
                                      child: BuildText(
                                        maxLines: 2,
                                        text: widget.senderID!,
                                        color: Colors.white,
                                        size: 15,
                                        letterSpacing: 1.5,
                                      ),
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
                                  size: 15,
                                  letterSpacing: 1.5,
                                ),
                                BuildText(
                                    text: widget.senderPhone!,
                                    color: Colors.white,
                                    size: 15,
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
                                  size: 15,
                                  letterSpacing: 1.5,
                                ),
                                SizedBox(
                                  width: width * .475,
                                  height: height * .1,
                                  child: Center(
                                    child: BuildText(
                                      text: widget.senderEmail!,
                                      color: Colors.white,
                                      size: 15,
                                      maxLines: 2,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
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
                                  size: 15,
                                  letterSpacing: 1.5,
                                ),
                                SizedBox(
                                    height: height * .075,
                                    width: width * .5,
                                    child: Center(
                                      child: BuildText(
                                        maxLines: 3,
                                        text: widget.taskId!,
                                        color: Colors.white,
                                        size: 15,
                                        letterSpacing: 1.5,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: height * .02,
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
                        SizedBox(
                          height: height * .01,
                        ),
                        BuildText(
                          maxLines: 150,
                          text: widget.description!,
                          bold: true,
                          color: Colors.black,
                          size: 15,
                          letterSpacing: 1.25,
                          wordSpacing: 1,
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
                        text: ' ${widget.year}/${widget.month}/${widget.day}',
                        bold: true,
                        color: Colors.black,
                        size: 20,
                        center: true,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: height * .01,
                  ),
                  SfSlider(
                    min: 0.0,
                    max: 100.0,
                    value: _value,
                    interval: 100,

                    activeColor: _value <33.3 ?Colors.red:_value<66.6&&_value >33.3 ?Colors.blue:Colors.green ,
                    showLabels: true,
                    enableTooltip: true,

                    minorTicksPerInterval: 1,
                    onChanged: (dynamic value){
                      setState(() {
                        _value = value;
                        print(value);
                      });
                    },
                  ),
                  widget.sender == false
                      ? Padding(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
