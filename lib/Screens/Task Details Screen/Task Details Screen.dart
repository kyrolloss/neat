
import 'package:action_slider/action_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/components/color.dart';
import 'package:neat/cubit/app_cubit.dart';
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
  String status;
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
    required this.status,
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
  ActionSliderController toDoController = ActionSliderController();
  ActionSliderController inProgressController = ActionSliderController();
  ActionSliderController completeController = ActionSliderController();

  @override
  void initState() {
    if (widget.status == 'to do') {
      toDoController.reset();

      toDoController.success();
    } else if (widget.status == 'in progress') {
      inProgressController.reset();

      inProgressController.success();
    } else if (widget.status == 'completed') {
      completeController.reset();

      completeController.success();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? now = DateTime.now();

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: Icon(Icons.arrow_back_ios_new_outlined , color: AppColor.primeColor,)),
                              BuildText(
                                text: widget.name!,
                                bold: true,
                                color: AppColor.primeColor,
                                size: 25,
                                center: true,
                              ),
                              SizedBox()
                            ],
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
                            text:
                                ' ${widget.year}/${widget.month}/${widget.day}',
                            bold: true,
                            color: Colors.black,
                            size: 20,
                            center: true,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .04,
                      ),
                      widget.sender == false
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: width * .95,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: height * .065,
                                      width: width * .25,
                                      child: ActionSlider.dual(
                                        backgroundBorderRadius:
                                            BorderRadius.circular(50.0),
                                        foregroundBorderRadius:
                                            BorderRadius.circular(50.0),
                                        width: 300.0,
                                        backgroundColor: AppColor.secondColor,
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2.0),
                                          child: Transform.rotate(
                                              angle: 0,
                                              child: const Icon(
                                                  Icons.title_outlined,
                                                  size: 28.0)),
                                        ),
                                        startAction: (controller) async {
                                          if (widget.status != 'to do') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'U Can not change to early step!'),
                                              ),
                                            );
                                          }
                                        },
                                        endAction: (controller) async {
                                          if (widget.status != 'to do') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'U Can not change to early step!'),
                                              ),
                                            );
                                          }
                                        },
                                        controller: toDoController,
                                        toggleColor: AppColor.primeColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * .065,
                                      width: width * .25,
                                      child: ActionSlider.dual(
                                        backgroundBorderRadius:
                                            BorderRadius.circular(50.0),
                                        foregroundBorderRadius:
                                            BorderRadius.circular(50.0),
                                        width: 300.0,
                                        backgroundColor: AppColor.secondColor,
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2.0),
                                          child: Transform.rotate(
                                              angle: 0,
                                              child: const Icon(
                                                  Icons.title_outlined,
                                                  size: 28.0)),
                                        ),
                                        startAction: (controller) async {
                                          setState(() {
                                            if (widget.status == 'to do') {
                                              controller
                                                  .loading(); //starts loading animation
                                              Future.delayed(
                                                  const Duration(seconds: 3));
                                              controller
                                                  .success(); //starts success animation
                                              Future.delayed(
                                                  const Duration(seconds: 1));
                                            }
                                          });
                                        },
                                        endAction: (controller) async {
                                          setState(() {
                                            if (widget.status == 'to do') {
                                              controller
                                                  .loading(); //starts loading animation
                                              Future.delayed(
                                                  const Duration(seconds: 3));
                                              FirebaseFirestore.instance
                                                  .collection('tasks_rooms')
                                                  .doc('taskRoomId')
                                                  .collection('tasks')
                                                  .where('id',
                                                      isEqualTo: widget.taskId)
                                                  .get()
                                                  .then((snapshot) {
                                                for (var doc in snapshot.docs) {
                                                  doc.reference.update({
                                                    'status': 'in progress',
                                                    'dayCompleted':now.day,
                                                    'monthCompleted':now.month,
                                                    'yearCompleted':now.year,
                                                  });
                                                }
                                              });
                                              controller
                                                  .success(); //starts success animation
                                              Future.delayed(
                                                  const Duration(seconds: 1));
                                              toDoController.reset();
                                              completeController.reset();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'U Can not change to early step!'),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                        controller: inProgressController,
                                        toggleColor: AppColor.primeColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * .065,
                                      width: width * .25,
                                      child: ActionSlider.dual(
                                        backgroundBorderRadius:
                                            BorderRadius.circular(50.0),
                                        foregroundBorderRadius:
                                            BorderRadius.circular(50.0),
                                        width: 300.0,
                                        backgroundColor: AppColor.secondColor,
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2.0),
                                          child: Transform.rotate(
                                              angle: 0,
                                              child: const Icon(
                                                  Icons.title_outlined,
                                                  size: 28.0)),
                                        ),
                                        startAction: (controller) async {
                                          setState(() {
                                            if (widget.status == 'to do' ||
                                                widget.status ==
                                                    'in progress') {
                                              controller
                                                  .loading(); //starts loading animation
                                              Future.delayed(
                                                  const Duration(seconds: 3));
                                              controller
                                                  .success(); //starts success animation
                                              Future.delayed(
                                                  const Duration(seconds: 1));
                                            }
                                          });
                                        },
                                        endAction: (controller) async {
                                          setState(() {
                                            if (widget.status == 'to do' ||
                                                widget.status ==
                                                    'in progress') {
                                              controller.loading();
                                              FirebaseFirestore.instance
                                                  .collection('tasks_rooms')
                                                  .doc('taskRoomId')
                                                  .collection('tasks')
                                                  .where('id',
                                                      isEqualTo: widget.taskId)
                                                  .get()
                                                  .then((snapshot) {
                                                for (var doc in snapshot.docs) {
                                                  doc.reference.update(
                                                      {
                                                        'status': 'completed',
                                                        'dayCompleted':now.day,
                                                        'monthCompleted':now.month,
                                                        'yearCompleted':now.year,




                                                      });
                                                }
                                              });
                                              Future.delayed(
                                                  const Duration(seconds: 3));
                                              controller
                                                  .success(); //starts success animation
                                              Future.delayed(
                                                  const Duration(seconds: 1));
                                              inProgressController.reset();
                                              toDoController.reset();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'U Can not change to early step!'),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                        controller: completeController,
                                        toggleColor: AppColor.primeColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )


                          : const SizedBox(),
                      widget.sender == false
                          ? SizedBox(
                              width: width * .95,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BuildText(
                                    text: 'To Do',
                                    color: AppColor.primeColor,
                                    bold: true,
                                    size: 17.5,
                                    letterSpacing: 1,
                                  ),
                                  BuildText(
                                    text: '  InProgress',
                                    color: AppColor.primeColor,
                                    bold: true,
                                    size: 17.5,
                                    letterSpacing: 1,
                                  ),
                                  BuildText(
                                    text: 'Completed',
                                    color: AppColor.primeColor,
                                    bold: true,
                                    size: 17.5,
                                    letterSpacing: 1,
                                  )
                                ],
                              ),
                            )
                          : const SizedBox(),
                      widget.sender == false
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
          );
        },
      ),
    );
  }
}
