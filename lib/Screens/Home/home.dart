import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../cubit/app_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String ReceiverId;

  const HomeScreen({super.key, required this.ReceiverId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = AppCubit.get(context);

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 22.5, left: 22.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, right: 15, left: 15, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xff6368d9),
                                  maxRadius: 35,
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
                                      color: AppColor.primeColor,
                                      size: 20,
                                    ),
                                    BuildText(
                                      text: 'Kerollos harby!',
                                      color: AppColor.primeColor,
                                      size: 20,
                                      bold: true,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .045,
                            ),
                            BuildText(
                              text: "Let's Check Out Your Tasks",
                              color: AppColor.primeColor,
                              size: 15,
                              bold: true,
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Container(
                              height: height * .225,
                              width: width * .775,
                              decoration: BoxDecoration(
                                  color: AppColor.primeColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "62.5% completed",
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
                                                  BorderRadius.circular(25)),
                                          child: LinearPercentIndicator(
                                            width: width * .65,
                                            lineHeight: height * .0085,
                                            percent: 0.3,
                                            backgroundColor:
                                                AppColor.primeColor,
                                            progressColor: AppColor.secondColor,
                                            barRadius: const Radius.circular(5),
                                            padding: const EdgeInsets.all(1),
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
                                              height: height * .09,
                                              width: width * .4,
                                              child: Center(
                                                child: BuildText(
                                                  text:
                                                      'You have 3 more tasks to do',
                                                  color: AppColor.secondColor,
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
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: height * .05,
                                        width: width * .3,
                                        decoration: BoxDecoration(
                                          color: AppColor.secondColor,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Center(
                                          child: BuildText(
                                            text: "Details",
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                color: AppColor.primeColor,
                child: SizedBox(
                    height: height * .5,
                    width: width * .875,
                    child:buildTaskList() ),
              )
            ],
          ),
        ),
      ),
    );
  },
);
  }


  Widget buildTaskList() {
    String SenderId = AppCubit.get(context).getCurrentUser()!.uid;

    return StreamBuilder(
      stream: AppCubit.get(context).getTasks(widget.ReceiverId, SenderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState) {
          return const Text('Loadingg');
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            color: AppColor.primeColor,
          );
        }

        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children:
          snapshot.data!.docs.map((doc) => BuildTaskItem(doc)).toList(),
        );
      },
    );
  }



  Widget BuildTaskItem(
    DocumentSnapshot doc,
  ) {
    var height = MediaQuery.of(context).size.height;

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * .1,
        width: 150,
        decoration: BoxDecoration(
            color: AppColor.secondColor,
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: width * .2,
                      child: BuildText(
                        text: 'collage stuff',
                        size: 17.5,
                        bold: true,
                        color: AppColor.primeColor,
                        maxLines: 2,
                      )),
                  SizedBox(
                    width: width * .2,
                    child: BuildText(
                      text: '27 task',
                      size: 17.5,
                      color: AppColor.primeColor,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.file_copy_outlined,
                color: AppColor.primeColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
