import 'package:flutter/material.dart';

import '../../../components/Text.dart';
import '../../../components/color.dart';
import '../../../components/components.dart';
import '../../../cubit/app_cubit.dart';
import '../../../utlis/constants/colors.dart';
import '../To do Tasks/to do tasks.dart';
class BuilderTodo extends StatelessWidget {
  const BuilderTodo({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Color textColor;
    return StreamBuilder(
      stream: AppCubit.get(context).performanceStream(),
      builder: (context, snapshot) {
        AppCubit.get(context).performanceStream().listen((event) {
          for (var doc in event.docs) {
            Map<String, dynamic> data = doc.data();
            if (data['status'] == 'to do') {
              AppCubit.get(context).numberOfTodoTasks = event.docs.length;
            }
          }
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
        return GestureDetector(
          onTap: () {
            navigateTo(context, const ToDoTasks());
          },
          child: Container(
            height: height * .15,
            width: width * .9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColor.secondColor,
            ),
            child: SizedBox(
              height: height * .1,
              width: width * .4,
              child: Center(
                child: BuildText(
                  text:
                  'You have ${AppCubit.get(context).numberOfTodoTasks} ToDo Task That You Sent',
                  color: TColors.primaryColor,
                  size: 17.50,
                  bold: true,
                  maxLines: 3,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}