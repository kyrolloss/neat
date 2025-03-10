import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/Screens/Profile/widgets/profile_picture.dart';
import 'package:neat/Screens/chat/users_screen.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/common/widgets/images/circular_image.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/components/components.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/image_strings.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../cubit/app_cubit.dart';
import '../Task Details Screen/Task Details Screen.dart';

class HomeScreen extends StatefulWidget {
  final String receiverId;

  const HomeScreen({
    super.key,
    required this.receiverId,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  int timeRemaining = 3;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          restartTimer();
        }
      });
    });
  }
  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  void restartTimer() {
    timer?.cancel();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {


    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: TAppBar(
            backgroundColor: Colors.transparent,
            showBackArrow: false,
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, const UsersScreen());
                  },
                  icon: Icon(
                    Icons.chat,
                    color: isDarkMode
                        ? TColors.secondaryColor
                        : TColors.primaryColor,
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    // Positioned(
                    //   right: 0,
                    //   top: 10,
                    //   child: IconButton(
                    //       onPressed: () {
                    //         navigateTo(context, const UsersScreen());
                    //       },
                    //       icon: const Icon(
                    //         Icons.chat,
                    //         color: TColors.primaryColor,
                    //       )),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    /// Profile picture
                                    ProfilePicture(cubit: cubit, width: 120, height: 130),
                                    SizedBox(
                                      width: width * .025,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BuildText(
                                          text: 'Hello,',
                                          color: isDarkMode
                                              ? TColors.secondaryColor
                                              : TColors.primaryColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: width*.45,
                                          height: height*.1,
                                          child: BuildText(
                                            text: cubit.name,
                                            maxLines: 3,
                                            color: isDarkMode
                                                ? TColors.secondaryColor
                                                : TColors.primaryColor,
                                            size: 20,
                                            bold: true,
                                          ),
                                        ),
                                      ],
                                    ),

                                    /// Chats
                                  ],
                                ),
                                SizedBox(
                                  height: height * .045,
                                ),
                                BuildText(
                                  text: "Let's Check Out Your Tasks",
                                  color: isDarkMode
                                      ? TColors.secondaryColor
                                      : TColors.primaryColor,
                                  size: 20,
                                  bold: true,
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                TCircularContainer(
                                  // height: height * .225,
                                  // width: width * .775,
                                  // decoration: BoxDecoration(
                                  //     color: AppColor.primeColor,
                                  //     borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: TColors.primaryColor,
                                  height: 200,
                                  width: 330,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${cubit.numberOfTodoTasks}",
                                              style: TextStyle(
                                                  color: AppColor.secondColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(
                                              height: height * .00425,
                                            ),
                                            Container(
                                              height: height * .009,
                                              width: width * .65,
                                              decoration: BoxDecoration(
                                                  color: AppColor.secondColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: LinearPercentIndicator(
                                                width: width * .65,
                                                lineHeight: height * .0085,
                                                percent: 0.3,
                                                backgroundColor:
                                                    AppColor.primeColor,
                                                progressColor:
                                                    AppColor.secondColor,
                                                barRadius:
                                                    const Radius.circular(5),
                                                padding:
                                                    const EdgeInsets.all(1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: TSizes.lg * 5,
                                                  width: width * .4,
                                                  child: Center(
                                                    child: BuildText(
                                                      text:
                                                          'You have ${cubit.numberOfTodoTasks} more tasks to do',
                                                      color:
                                                          AppColor.secondColor,
                                                      size: 20,
                                                      bold: true,
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(
                    height: height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0, bottom: 12),
                        child: BuildText(
                          text: 'Task',
                          color: AppColor.primeColor,
                          size: 15,
                          bold: true,
                        ),
                      ),
                    ],
                  ),
                  DottedBorder(
                    dashPattern: const [8, 6],
                    strokeWidth: 2,
                    color: isDarkMode
                        ? TColors.secondaryColor
                        : TColors.primaryColor,
                    child: SizedBox(
                        height: height * .5,
                        width: width * .875,
                        child: Padding(
                          padding:
                              const EdgeInsets.all(TSizes.defaultSpace / 2),
                          child: BuilderTasksList(),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget BuilderTasksList() {
    return StreamBuilder(
      stream: AppCubit.get(context).getTasksStream(),
      builder: (context, snapshot) {
        AppCubit.get(context).getTasksStream().listen((event) {
          AppCubit.get(context).numberOfTodoTasks = event.docs.length;
        });
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
              crossAxisCount: 2, childAspectRatio: 1.5),
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
              sender: false,
              status: taskData['status'],
              imageURl:  taskData['image'],

            ));
      },
      child: Padding(
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
      ),
    );
  }

//
// Widget buildTaskList() {
//   String SenderId = AppCubit.get(context).getCurrentUser()!.uid;
//
//   return StreamBuilder(
//     stream: AppCubit.get(context).getTasks(widget.ReceiverId, SenderId),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return const Text('error');
//       }
//       if (snapshot.connectionState == ConnectionState) {
//         return const Text('Loadingg');
//       }
//       if (!snapshot.hasData) {
//         return CircularProgressIndicator(
//           color: AppColor.primeColor,
//         );
//       }
//
//       return GridView(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         children:
//         snapshot.data!.docs.map((doc) => BuildTaskItem(doc)).toList(),
//       );
//     },
//   );
// }
//
//
//
// Widget BuildTaskItem(
//   DocumentSnapshot doc,
// ) {
//   var height = MediaQuery.of(context).size.height;
//
//   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//   var width = MediaQuery.of(context).size.width;
//
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//       height: height * .1,
//       width: 150,
//       decoration: BoxDecoration(
//           color: AppColor.secondColor,
//           borderRadius: BorderRadius.circular(25)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                     width: width * .2,
//                     child: BuildText(
//                       text: data['tasks'],
//                       size: 17.5,
//                       bold: true,
//                       color: AppColor.primeColor,
//                       maxLines: 2,
//                     )),
//                 SizedBox(
//                   width: width * .2,
//                   child: BuildText(
//                     text: data.length.toString(),
//                     size: 17.5,
//                     color: AppColor.primeColor,
//                     maxLines: 2,
//                   ),
//                 ),
//               ],
//             ),
//             Icon(
//               Icons.file_copy_outlined,
//               color: AppColor.primeColor,
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
