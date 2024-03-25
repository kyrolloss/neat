import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/cubit/app_cubit.dart';

class TaskTemplateScreen extends StatefulWidget {
  const TaskTemplateScreen({super.key});

  @override
  State<TaskTemplateScreen> createState() => _TaskTemplateScreenState();
}

class _TaskTemplateScreenState extends State<TaskTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController taskNameController = TextEditingController();
    TextEditingController taskDescriptionController = TextEditingController();

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
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * .08,
                        ),
                        BuildText(
                          text: 'Task Name',
                          color: AppColor.primeColor,
                          size: 25,
                          bold: true,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        SizedBox(
                          height: height * .065,
                          width: width * .975,
                          child: TextFormField(
                            controller: taskNameController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                fillColor: AppColor.primeColor.withOpacity(.6),
                                filled: true,
                                hintText: 'Name ...',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.5),
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
                          size: 25,
                          bold: true,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),

                        SizedBox(
                          height: height * .065,
                          width: width * .975,
                          child: TextFormField(
                            controller: taskDescriptionController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                fillColor: AppColor.primeColor.withOpacity(.6),
                                filled: true,
                                hintText: 'Description ...',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.5),
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

                        Row(
                          children: [
                            BuildText(
                              text: 'Start Day ...',
                              color: AppColor.primeColor,
                              size: 25,
                              bold: true,
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
                              text: 'DeadLine ...',
                              color: AppColor.primeColor,
                              size: 25,
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
                          height: height * .02,
                        ),

                        Row(
                          children: [
                            BuildText(
                              text: 'Attachment ...',
                              color: AppColor.primeColor,
                              size: 25,
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
                GestureDetector(
                  onTap: () {
                    var uuid = Uuid();
                    cubit.sendTask(
                      receiverID: 'L3WpJirKigReDoH3vqyF13RuY7M2',
                      senderID: 'fiyT0flMHFdXHuotIjgREGNczkP2',
                      title: 'Hr',
                      description: """
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
                        """,
                      deadline: 'next friday',
                      senderName: 'kerollos',
                      senderPhone: '01205708870',
                      taskName: 'newTask',
                      taskId: uuid.v1(),
                      priority: 'important', status: 'inProgress',

                    );
                  },
                  child: Container(
                    height: height * .075,
                    width: width * .975,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.primeColor,
                    ),
                    child: Center(
                        child: BuildText(
                      text: 'done',
                      size: 25,
                      color: Colors.white,
                      bold: true,
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
