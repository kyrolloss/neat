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
import '../../Screens/chat/users_screen.dart';

class adminHomeScreen extends StatefulWidget {
  final String receiverId;

  const adminHomeScreen({
    super.key,
    required this.receiverId,
  });

  @override
  State<adminHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<adminHomeScreen> {
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
                            navigateTo(
                                context, const UsersScreen());
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                            onTap: () async {},
                            child: Container(
                              height: height * .04,
                              width: width * .5,
                              decoration: BoxDecoration(
                                color: AppColor.secondColor,
                                borderRadius:
                                BorderRadius.circular(25),
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
                    text:
                    'Your Team Performance',
                    color: AppColor.primeColor,
                    size: 20,
                    bold: true,
                    maxLines: 3,
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