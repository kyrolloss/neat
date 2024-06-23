import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/texts/section_heading.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/sizes.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/cubit/app_cubit.dart';

import '../utlis/constants/themes/theme_provider.dart';

class TaskTemplateScreen extends StatefulWidget {

  const TaskTemplateScreen({super.key, });

  @override
  State<TaskTemplateScreen> createState() => _TaskTemplateScreenState();
}

class _TaskTemplateScreenState extends State<TaskTemplateScreen> {
  String priority = '';
  Color box1Color = AppColor.primeColor;
  Color box2Color = AppColor.primeColor;
  Color box3Color = AppColor.primeColor;

  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController receiverID = TextEditingController();

  String _taskName = '';
  String _taskDescription = '';
  String _receiverId = '';
  File? file;
  String? url;

  getImageGallery({required BuildContext context}) async {
    final ImagePicker picker = ImagePicker();

    /// Pick an image.
    final XFile? imageGallery =
    await picker.pickImage(source: ImageSource.gallery);
    if (imageGallery != null) {
      file = File(imageGallery!.path);
      var imageName = basename(imageGallery!.path);

      /// start upload
      var random = Random().nextInt(10000000);
      imageName = "$random$imageName";

      var refStorage = FirebaseStorage.instance.ref("TaskTemplateImages/$imageName");
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
      print(url);



      /// end upload
    } else {
      if (kDebugMode) {
        print("Please choose Image");
      }
    }

    setState(() {
      if (imageGallery != null) {
        file = File(imageGallery.path);
      }
    });

    getImagesAndFolderName() async {
      var ref = await FirebaseStorage.instance.ref("ProfileImg").list();
      for (var element in ref.items) {
        if (kDebugMode) {
          print("**********");
        }
        if (kDebugMode) {
          print(element.name);
        }
      }
    }
  }

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
              backgroundColor: Colors.transparent,
              showBackArrow: false,
              iconColor:
                  isDarkMode ? TColors.secondaryColor : TColors.primaryColor,
              title: Text("Create Task",
                  style: Theme.of(context).textTheme.titleMedium!.apply(
                      color: isDarkMode
                          ? TColors.secondaryColor
                          : TColors.primaryColor))),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title: 'Task Name',
                        showActionButton: false,
                        textColor: isDarkMode
                            ? TColors.secondaryColor
                            : TColors.primaryColor,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      SizedBox(
                        height: height * .065,
                        width: width * .975,
                        child: TextFormField(
                          style: TextStyle(
                              color: isDarkMode
                                  ? TColors.secondaryColor
                                  : TColors.primaryColor),
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
                              fillColor: isDarkMode
                                  ? Colors.grey.shade900
                                  : TColors.backgroundColor,
                              filled: true,
                              hintText: ' Name ...',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? TColors.secondaryColor
                                    : TColors.primaryColor.withOpacity(0.7),
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  gapPadding: 20,
                                  borderSide: const BorderSide(
                                    color: TColors.primaryColor,
                                  )),
                              counterStyle: const TextStyle(
                                  color: TColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TSectionHeading(
                        title: 'Task Description',
                        showActionButton: false,
                        textColor: isDarkMode
                            ? TColors.secondaryColor
                            : TColors.primaryColor,
                      ),

                      SizedBox(
                        height: height * .01,
                      ),
                      SizedBox(
                        height: height * .065,
                        width: width * .975,
                        child: TextFormField(
                          style: TextStyle(
                              color: isDarkMode
                                  ? TColors.secondaryColor
                                  : TColors.primaryColor),
                          onChanged: (value) {
                            setState(() {
                              _taskDescription = value;
                            });
                          },
                          controller: taskDescriptionController,
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
                              fillColor: isDarkMode
                                  ? Colors.grey.shade900
                                  : TColors.backgroundColor,
                              filled: true,
                              hintText: 'Description ...',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: isDarkMode
                                    ? TColors.secondaryColor
                                    : TColors.primaryColor.withOpacity(0.7),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  gapPadding: 20,
                                  borderSide: const BorderSide(
                                    color: TColors.primaryColor,
                                  )),
                              counterStyle: const TextStyle(
                                  color: TColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),

                      //
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),

                      TSectionHeading(
                        title: "Receiver ID",
                        showActionButton: false,
                        textColor: isDarkMode
                            ? TColors.secondaryColor
                            : TColors.primaryColor,
                      ),

                      SizedBox(
                        height: height * .01,
                      ),
                      SizedBox(
                        height: height * .065,
                        width: width * .975,
                        child: TextFormField(
                          style: TextStyle(
                              color: isDarkMode
                                  ? TColors.secondaryColor
                                  : isDarkMode
                                      ? TColors.secondaryColor
                                      : TColors.primaryColor),
                          onChanged: (value) {
                            setState(() {
                              _receiverId = value;
                            });
                          },
                          controller: receiverID,
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
                              fillColor: isDarkMode
                                  ? Colors.grey.shade900
                                  : TColors.backgroundColor,
                              filled: true,
                              hintText: 'ID... ',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: isDarkMode
                                    ? TColors.secondaryColor
                                    : TColors.primaryColor.withOpacity(0.7),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                gapPadding: 20,
                                borderSide: const BorderSide(
                                    color: TColors.primaryColor),
                              ),
                              counterStyle: const TextStyle(
                                  color: TColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),

                      //

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      SizedBox(
                        height: height * .01,
                      ),
                      TSectionHeading(
                        title: "Priority",
                        showActionButton: false,
                        textColor: isDarkMode
                            ? TColors.secondaryColor
                            : TColors.primaryColor,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                box1Color = TColors.secondaryColor;
                                box2Color = TColors.primaryColor;
                                box3Color = TColors.primaryColor;
                                priority = 'Low';
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
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                box2Color = TColors.secondaryColor;
                                box1Color = TColors.primaryColor;
                                box3Color = TColors.primaryColor;
                                priority = 'medium';
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
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          GestureDetector(

                            onTap: () {
                              setState(() {
                                box3Color = TColors.secondaryColor;
                                box2Color = TColors.primaryColor;
                                box1Color = TColors.primaryColor;
                                priority = 'high';

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
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      Row(
                        children: [
                          TSectionHeading(
                            title: 'DeadLine ',
                            showActionButton: false,
                            textColor: isDarkMode
                                ? TColors.secondaryColor
                                : TColors.primaryColor,
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
                            color: isDarkMode
                                ? TColors.secondaryColor
                                : TColors.primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      Row(
                        children: [
                          TSectionHeading(
                            title: 'Attachment',
                            showActionButton: false,
                            textColor: isDarkMode
                                ? TColors.secondaryColor
                                : TColors.primaryColor,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async{
                              getImageGallery(context: context, );
                            },
                            icon: const Icon(
                              Icons.attach_file_outlined,
                              // Use a more appropriate calendar icon
                              size: 32.5,
                            ),
                            color: isDarkMode
                                ? TColors.secondaryColor
                                : TColors.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (priority == '') {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please Select Priority'),
                              ),
                            );
                          }
                          else if(
                            receiverID.text.toString() == cubit.id
                          ){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Can not send to yourself'),
                              ),
                            );
                          }
                          else if(
                          receiverID.text.isEmpty||taskNameController.text.isEmpty||taskDescriptionController.text.isEmpty
                          ){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please fill out all fields'),
                              ),
                            );
                          }
                          else if(
                          receiverID.text.isEmpty||taskNameController.text.isEmpty||taskDescriptionController.text.isEmpty
                          ){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please fill out all fields'),
                              ),
                            );
                          }

                          else if(
                          cubit.year==0||cubit.day==0||cubit.month==0
                          ){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please choose the date'),
                              ),
                            );
                          }


                          else{
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
                              url: url
                            );
                            taskNameController.clear();
                            taskDescriptionController.clear();
                            cubit.year=0;
                            cubit.day=0;
                            cubit.month=0;
                            receiverID.clear();
                          }

                        },
                        child: Container(
                          height: height * .065,
                          width: width * .625,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColor.primeColor,
                          ),
                          child: Center(
                              child: Text(
                            "Send Now",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: TColors.backgroundColor),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 4,
                      ),
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
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
