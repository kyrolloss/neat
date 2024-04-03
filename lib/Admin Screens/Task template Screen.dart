import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/cubit/app_cubit.dart';

class TaskTemplateScreen extends StatefulWidget {
  final String senderID;

  const TaskTemplateScreen({super.key , required this.senderID});

  @override
  State<TaskTemplateScreen> createState() => _TaskTemplateScreenState();
}

class _TaskTemplateScreenState extends State<TaskTemplateScreen> {
  String priority = 'Low';
  Color box1Color = AppColor.primeColor;
  Color box2Color = AppColor.secondColor;
  Color box3Color = AppColor.secondColor;

  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController receiverID = TextEditingController();


  void _toggleBoxColor(int boxNumber) {
    setState(() {
      if (boxNumber == 1) {
        box1Color = AppColor.primeColor;
        box2Color = AppColor.secondColor;
        box3Color = AppColor.secondColor;
        priority = 'Low';

      } else if (boxNumber == 2) {
        box1Color = AppColor.secondColor;
        box2Color = AppColor.primeColor;
        box3Color = AppColor.secondColor;
        priority = 'medium';
      } else if (boxNumber == 3) {
        box1Color = AppColor.secondColor;
        box2Color = AppColor.secondColor;
        box3Color = AppColor.primeColor;
        priority = 'high';

      }

      setState(() {
        // Save the current taskName and taskDescription values
        _taskName = taskNameController.text;
        _taskDescription = taskDescriptionController.text;

        // TODO: Show the priority picker
      });
    });
  }





  String _taskName = '';
  String _taskDescription = '';
  String _receiverId = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;



    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * .08,
                        ),
                        BuildText(
                          text: 'Task Name',
                          color: AppColor.primeColor,
                          size: 20,
                          bold: true,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        SizedBox(
                          height: height * .065,
                          width: width * .975,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _taskName = value;
                              });
                            },
                            controller: taskNameController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                fillColor: AppColor.primeColor.withOpacity(.6),
                                filled: true,
                                hintText: 'Name ...',
                                hintStyle:  const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15 ,),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    gapPadding: 20,
                                    borderSide: BorderSide.none),
                                counterStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),

                        //

                        SizedBox(
                          height: height * .01,
                        ),
                        const Divider(),

                        BuildText(
                          text: 'Task Description',
                          color: AppColor.primeColor,
                          size: 20,
                          bold: true,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),

                        SizedBox(
                          height: height * .065,
                          width: width * .975,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _taskDescription = value;
                              });
                            },
                            controller: taskDescriptionController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                fillColor: AppColor.primeColor.withOpacity(.6),
                                filled: true,
                                hintText: 'Description ...',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    gapPadding: 20,
                                    borderSide: BorderSide.none),
                                counterStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),

                        //
                        SizedBox(
                          height: height * .01,
                        ),
                        const Divider(),
                        SizedBox(
                          height: height * .01,
                        ),


                        BuildText(
                          text: 'Receiver ID',
                          color: AppColor.primeColor,
                          size: 20,
                          bold: true,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        SizedBox(
                          height: height * .065,
                          width: width * .975,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _receiverId = value;
                              });
                            },
                            controller: receiverID,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                fillColor: AppColor.primeColor.withOpacity(.6),
                                filled: true,
                                hintText: 'ID ...',
                                hintStyle:  const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15 ,),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    gapPadding: 20,
                                    borderSide: BorderSide.none),
                                counterStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),

                        //

                        SizedBox(
                          height: height * .01,
                        ),
                        const Divider(),

                        // Row(
                        //   children: [
                        //     BuildText(
                        //       text: 'Priority ...',
                        //       color: AppColor.primeColor,
                        //       size: 20,
                        //       bold: true,
                        //     ),
                        //     const Spacer(),
                        //     DropdownButton<String>(
                        //       value: selectedPriority,
                        //       onChanged: (newValue) {
                        //         setState(() {
                        //           selectedPriority = newValue!;
                        //         });
                        //       },
                        //       items: <String>['Low', 'Medium', 'High']
                        //           .map<DropdownMenuItem<String>>((String value) {
                        //         return DropdownMenuItem<String>(
                        //           value: value,
                        //           child: Text(value , style: TextStyle(
                        //               color: AppColor.primeColor,fontWeight: FontWeight.bold
                        //           ),),
                        //         );
                        //       }).toList(),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: height * .01,
                        ),
                        BuildText(
                          text: 'Priority ...',
                          color: AppColor.primeColor,
                          size: 20,
                          bold: true,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => _toggleBoxColor(1),
                              child: Container(
                                width: width*.3,
                                height: height*.075,
                                decoration: BoxDecoration(
                                    color: box1Color,

                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: const Center(child: Text('Low')),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _toggleBoxColor(2),
                              child: Container(
                                width: width*.3,
                                height: height*.075,
                                decoration: BoxDecoration(
                                    color: box2Color,

                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: const Center(child: Text('medium')),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _toggleBoxColor(3),
                              child: Container(
                                width: width*.3,
                                height: height*.075,
                                decoration: BoxDecoration(
                                    color: box3Color,

                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: const Center(child: Text('high')),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),

                        Row(
                          children: [
                            BuildText(
                              text: 'DeadLine ...',
                              color: AppColor.primeColor,
                              size: 20,
                              bold: true,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                await cubit.showCalendar(context);
                              },
                              icon: const Icon(
                                Icons.calendar_today,
                                // Use a more appropriate calendar icon
                                size: 30,
                              ),
                              color: AppColor.primeColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),

                        Row(
                          children: [
                            BuildText(
                              text: 'Attachment ...',
                              color: AppColor.primeColor,
                              size: 20,
                              bold: true,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.attach_file,
                                // Use a more appropriate calendar icon
                                size: 32.5,
                              ),
                              color: AppColor.primeColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .008,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        var uuid = const Uuid();
                        cubit.sendTask(
                          receiverID: receiverID.text.toString(),
                          senderID: cubit.id ,
                          title: cubit.title,
                          description: taskDescriptionController.text.toString(),
                          senderName: cubit.name,
                          senderPhone: cubit.phone,
                          taskName: taskNameController.text.toString(),
                          taskId: uuid.v1(),
                          priority: priority  ,
                          status: 'to do',
                          year:cubit.year,
                          day: cubit.day,
                          month: cubit.month,

                        );
                      },
                      child: Container(
                        height: height * .075,
                        width: width * .725,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColor.primeColor,
                        ),
                        child: Center(
                            child: BuildText(
                              text: 'Send Now',
                              size: 25,
                              color: Colors.white,
                              bold: true,
                            )),
                      ),
                    ),
                    Container(
                        height: height * .075,
                        width: width * .13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColor.primeColor,
                        ),
                        child:const Icon(Iconsax.message_time5 , color: Colors.white,size: 25,)
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}