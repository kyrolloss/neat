// import 'package:flutter/material.dart';
//
// import '../../../components/Text.dart';
// import '../../../components/color.dart';
// import '../../../components/components.dart';
// import '../../../cubit/app_cubit.dart';
// import '../../../utlis/constants/colors.dart';
// import '../In progress tasks/in Progress tasks.dart';
// class BuilderProgress extends StatelessWidget {
//   const BuilderProgress({
//     super.key,
//     required this.context,
//   });
//
//   final BuildContext context;
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     return StreamBuilder(
//       stream: AppCubit.get(context).performanceStream(),
//       builder: (context, snapshot) {
//         AppCubit.get(context).performanceStream().listen((event) {
//           for (var doc in event.docs) {
//             Map<String, dynamic> data = doc.data();
//             if (data['status'] == 'inProgress') {
//               AppCubit.get(context).numberOfInProgressTasks = event.docs.length;
//             }
//           }
//         });
//         if (snapshot.hasError) {
//           return const Text('error');
//         }
//         if (snapshot.connectionState == ConnectionState) {
//           return const Text('Loading');
//         }
//         if (!snapshot.hasData) {
//           return CircularProgressIndicator(
//             color: AppColor.primeColor,
//           );
//         }
//         return GestureDetector(
//           onTap: () {
//             navigateTo(context, const inProgressTasks());
//           },
//           child: Container(
//             height: height * .15,
//             width: width * .9,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               color: AppColor.secondColor,
//             ),
//             child: SizedBox(
//               height: height * .1,
//               width: width * .4,
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: BuildText(
//                     text:
//                     'You have ${AppCubit.get(context).numberOfInProgressTasks} in Progress Task That You Sent',
//                     color: TColors.primaryColor,
//                     size: 17.50,
//                     bold: true,
//                     maxLines: 3,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }