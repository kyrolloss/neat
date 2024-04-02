import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:neat/common/widgets/images/circular_image.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/components/components.dart';
import 'package:neat/cubit/app_cubit.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/image_strings.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:neat/utlis/constants/themes/theme_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../Screens/Task Details Screen/Task Details Screen.dart';
import '../../Screens/chat/users_screen.dart';

class adminHomeScreen extends StatefulWidget {
  final String receiverId;

  const adminHomeScreen({
    super.key,
    required this.receiverId,
  });

  @override
  State<adminHomeScreen> createState() => _adminHomeScreenState();
}

class _adminHomeScreenState extends State<adminHomeScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String selectedValue = 'Email';
  List<String> values = ['ID', 'Email'];

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
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TCircularImage(
                        image: TImages.user,
                        width: 90,
                        height: 90,
                      ),
                      SizedBox(
                        width: width * .025,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildText(
                            text: 'Hello,',
                            color: isDarkMode
                                ? TColors.secondaryColor
                                : TColors.primaryColor,
                            size: 20,
                          ),
                          BuildText(
                            text: 'cubit.name',
                            color: isDarkMode
                                ? TColors.secondaryColor
                                : TColors.primaryColor,
                            size: 20,
                            bold: true,
                          ),
                        ],
                      ),
                      const Spacer(),
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

                      /// Chats
                    ],
                  ),
                  SizedBox(
                    height: height * .045,
                  ),
                  BuildText(
                    text: "Let's Check the performance",
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
                    backgroundColor: TColors.primaryColor,
                    width: width * .85,
                    height: height * .2,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: TSizes.lg * 3.5,
                            width: width * .4,
                            child: Center(
                              child: BuildText(
                                text:
                                    'U have 3 Individuals Under Your Supervision',
                                color: AppColor.secondColor,
                                size: 20,
                                bold: true,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Dialog(
                                        child: Container(
                                          height: height * .3,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Center(
                                                child: DropdownButton<String>(
                                                  value: selectedValue,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      // تحديث القيمة المختارة
                                                      selectedValue = newValue!;
                                                    });
                                                  },
                                                  items: values.map((value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              selectedValue == 'ID'
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: TextFormField(
                                                        controller:
                                                            idController,
                                                        cursorColor:
                                                            Colors.black,
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                fillColor: AppColor
                                                                    .secondColor,
                                                                filled: true,
                                                                hintText:
                                                                    'ID ...',
                                                                hintStyle:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    gapPadding:
                                                                        20,
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none),
                                                                counterStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: TextFormField(
                                                        controller:
                                                            emailController,
                                                        cursorColor:
                                                            Colors.black,
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                fillColor: AppColor
                                                                    .secondColor,
                                                                filled: true,
                                                                hintText:
                                                                    'Email ...',
                                                                hintStyle:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    gapPadding:
                                                                        20,
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none),
                                                                counterStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                      ),
                                                    ),
                                              selectedValue == 'ID'
                                                  ? GestureDetector(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          cubit.addMemberToGroup(
                                                              idController.text
                                                                  .toString());
                                                          idController.clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: height * .04,
                                                          width: width * .3,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor
                                                                .primeColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                          child: Center(
                                                            child: BuildText(
                                                              text: "Add ",
                                                              color: AppColor
                                                                  .secondColor,
                                                              size: 17.5,
                                                              bold: true,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                onTap: () async {
                                                  cubit.addMemberToGroupByEmail(
                                                      emailController.text
                                                          .toString());
                                                  emailController.clear();
                                                  Navigator.pop(
                                                      context);
                                                },
                                                child: Container(
                                                  height: height * .04,
                                                  width: width * .3,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: AppColor
                                                        .primeColor,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        25),
                                                  ),
                                                  child: Center(
                                                    child: BuildText(
                                                      text: "Add ",
                                                      color: AppColor
                                                          .secondColor,
                                                      size: 17.5,
                                                      bold: true,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: height * .04,
                              width: width * .5,
                              decoration: BoxDecoration(
                                color: AppColor.secondColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: BuildText(
                                  text: "Add a new individual",
                                  color: AppColor.primeColor,
                                  size: 17.5,
                                  bold: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),

                  BuildText(
                    text: 'Your Team Performance',
                    color: AppColor.primeColor,
                    size: 20,
                    bold: true,
                    maxLines: 3,
                  ),

                  BuilderTasksList()


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
      stream: AppCubit.get(context).performanceStream( ),
      builder: (context, snapshot) {
        AppCubit.get(context)
            .getTasksStream( )
            .listen((event) {
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
              taskId: taskData['id'],
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
            child:Center(
              child: BuildText(text: 'You have ${ AppCubit.get(context).numberOfTodoTasks} ToDo Task That You Sent'),

            )
            //
          ),
        ),
      ),
    );
  }
}


// Row(
//
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Icon(
//       Icons.note_sharp,
//       color: AppColor.primeColor,
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//             width: width * .2,
//             child: BuildText(
//               text: taskData['name'],
//               size: 17.5,
//               bold: true,
//               color: AppColor.primeColor,
//               maxLines: 2,
//             )),
//       ],
//     ),
//   ],
// ),