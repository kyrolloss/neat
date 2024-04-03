import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/texts/section_heading.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/cubit/app_cubit.dart';

import '../utlis/constants/themes/theme_provider.dart';

class TaskTemplateScreen extends StatefulWidget {
  final String senderID;

  const TaskTemplateScreen({super.key, required this.senderID});

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
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: TAppBar(
              backgroundColor:  Colors.transparent,
              showBackArrow: true,
              iconColor: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
              title: Text("Create Task",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color:isDarkMode? TColors.secondaryColor : TColors.primaryColor))),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: height * .08,
                      // ),
                      TSectionHeading(
                        title: 'Task Name',
                        showActionButton: false,
                        textColor: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                      ),

                      SizedBox(
                        height: height * .01,
                      ),
                      SizedBox(
                        height: height * .065,
                        width: width * .975,
                        child: TextFormField(
                          style: TextStyle(color: isDarkMode? TColors.secondaryColor : TColors.primaryColor),
                          onChanged: (value) {
                            setState(() {
                              _taskName = value;
                            });
                          },
                          controller: taskNameController,
                          cursorColor: TColors.primaryColor,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: TColors.secondaryColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: TColors.primaryColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              fillColor: isDarkMode? Colors.grey.shade900 : TColors.backgroundColor,
                              filled: true,
                              hintText: ' Name ...',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:isDarkMode? TColors.secondaryColor : TColors.primaryColor.withOpacity(0.7),
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  gapPadding: 20,
                                  borderSide: BorderSide(
                                    color: TColors.primaryColor,
                                  )),
                              counterStyle: const TextStyle(
                                  color: TColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),

                      //

                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      // const Divider(color: TColors.secondaryColor,),

                      TSectionHeading(
                        title: 'Task Description',
                        showActionButton: false,
                        textColor: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                      ),

                      SizedBox(
                        height: height * .01,
                      ),

                      SizedBox(
                        height: height * .065,
                        width: width * .975,
                        child: TextFormField(
                          style: TextStyle(color: isDarkMode? TColors.secondaryColor :TColors.primaryColor),
                          onChanged: (value) {
                            setState(() {
                              _taskDescription = value;
                            });
                          },
                          controller: taskDescriptionController,
                          cursorColor: TColors.primaryColor,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.secondaryColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.primaryColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              fillColor: isDarkMode? Colors.grey.shade900 : TColors.backgroundColor,
                              filled: true,
                              hintText: 'Description ...',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                color:isDarkMode? TColors.secondaryColor : TColors.primaryColor.withOpacity(0.7),),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  gapPadding: 20,
                                  borderSide: BorderSide(
                                    color: TColors.primaryColor,
                                  )),
                              counterStyle: const TextStyle(
                                  color: TColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),

                      //
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),

                      TSectionHeading(
                        title: "Receiver ID",
                        showActionButton: false,
                        textColor: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                      ),

                      SizedBox(
                        height: height * .01,
                      ),
                      SizedBox(
                        height: height * .065,
                        width: width * .975,
                        child: TextFormField(
                          style: TextStyle(color:isDarkMode? TColors.secondaryColor :isDarkMode? TColors.secondaryColor : TColors.primaryColor),
                          onChanged: (value) {
                            setState(() {
                              _receiverId = value;
                            });
                          },
                          controller: receiverID,
                          cursorColor: TColors.primaryColor,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.secondaryColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: TColors.primaryColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              fillColor: isDarkMode? Colors.grey.shade900 : TColors.backgroundColor,
                              filled: true,
                              hintText: 'ID... ',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,

                                color:isDarkMode? TColors.secondaryColor : TColors.primaryColor.withOpacity(0.7),),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                gapPadding: 20,
                                borderSide:
                                    BorderSide(color: TColors.primaryColor),
                              ),
                              counterStyle: const TextStyle(
                                  color: TColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),

                      //

                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

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
                      TSectionHeading(
                        title: "Priority",
                        showActionButton: false,
                        textColor: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),

                      Row(
                        children: [
                          GestureDetector(
                            onTapDown: (_) {
                              setState(() {
                                box1Color = TColors.secondaryColor;
                                box2Color = TColors.primaryColor;
                                box3Color = TColors.primaryColor;
                              });
                            },
                            onTapUp: (_) {
                              setState(() {
                                box1Color = TColors.secondaryColor;
                                box2Color = TColors.primaryColor;
                                box3Color = TColors.primaryColor;
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                box1Color = TColors.primaryColor;
                              });
                            },
                            child: Container(
                              width: width * .2,
                              height: height * .065,
                              decoration: BoxDecoration(
                                  color: box1Color,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Center(
                                  child: Text(
                                'Low',
                                style: TextStyle(
                                    color: box1Color == TColors.primaryColor
                                        ? TColors.backgroundColor
                                        : TColors.primaryColor),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          GestureDetector(
                            onTapDown: (_) {
                              setState(() {
                                box2Color = TColors.secondaryColor;
                                box1Color = TColors.primaryColor;
                                box3Color = TColors.primaryColor;
                              });
                            },
                            onTapUp: (_) {
                              setState(() {
                                box2Color = TColors.secondaryColor;
                                box1Color = TColors.primaryColor;
                                box3Color = TColors.primaryColor;
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                box2Color = TColors.primaryColor;
                              });
                            },
                            child: Container(
                              width: width * .3,
                              height: height * .065,
                              decoration: BoxDecoration(
                                  color: box2Color,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                  child: Text(
                                'medium',
                                style: TextStyle(
                                    color: box2Color == TColors.primaryColor
                                        ? TColors.backgroundColor
                                        : TColors.primaryColor),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          GestureDetector(
                            onTapDown: (_) {
                              setState(() {
                                box3Color = TColors.secondaryColor;
                                box2Color = TColors.primaryColor;
                                box1Color = TColors.primaryColor;
                              });
                            },
                            onTapUp: (_) {
                              setState(() {
                                box3Color = TColors.secondaryColor;
                                box2Color = TColors.primaryColor;
                                box1Color = TColors.primaryColor;
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                box3Color = TColors.primaryColor;
                              });
                            },
                            child: Container(
                              width: width * .3,
                              height: height * .065,
                              decoration: BoxDecoration(
                                  color: box3Color,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Center(
                                  child: Text(
                                'high',
                                style: TextStyle(
                                    color: box3Color == TColors.primaryColor
                                        ? TColors.backgroundColor
                                        : TColors.primaryColor),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      Row(
                        children: [
                          TSectionHeading(
                            title: 'DeadLine ',
                            showActionButton: false,
                            textColor: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              await cubit.showCalendar(context);
                            },
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              // Use a more appropriate calendar icon
                              size: 30,
                            ),
                            color: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      Row(
                        children: [
                          TSectionHeading(
                            title: 'Attachment',
                            showActionButton: false,
                            textColor:isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file_outlined,
                              // Use a more appropriate calendar icon
                              size: 32.5,
                            ),
                            color: isDarkMode? TColors.secondaryColor : TColors.primaryColor,
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: height * .008,
                      // ),
                    ],
                  ),
                  SizedBox(height: TSizes.spaceBtwItems*2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          var uuid = const Uuid();
                          cubit.sendTask(
                            receiverID: receiverID.text.toString(),
                            senderID: cubit.id,
                            title: cubit.title,
                            description:
                                taskDescriptionController.text.toString(),
                            senderName: cubit.name,
                            senderPhone: cubit.phone,
                            taskName: taskNameController.text.toString(),
                            taskId: uuid.v1(),
                            priority: priority,
                            status: 'to do',
                            year: cubit.year,
                            day: cubit.day,
                            month: cubit.month,
                          );
                        },
                        child: Container(
                          height: height * .065,
                          width: width * .625,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColor.primeColor,
                          ),
                          child: Center(
                              child: Text("Send Now", style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.backgroundColor),)),
                        ),
                      ),
                      SizedBox(width: TSizes.spaceBtwItems/4,),
                      Container(
                          height: height * .065,
                          width: width * .13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: TColors.secondaryColor,
                          ),
                          child: const Icon(
                            Iconsax.message_time5,
                            color: TColors.primaryColor,
                            size: 25,
                          )),
                    ],
                  ),
                  SizedBox(height: TSizes.spaceBtwSections,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}