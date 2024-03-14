import 'package:flutter/material.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/common/widgets/images/circular_image.dart';
import 'package:neat/common/widgets/texts/section_heading.dart';
import 'package:neat/utlis/constants/colors.dart';
import 'package:neat/utlis/constants/image_strings.dart';
import 'package:neat/utlis/constants/sizes.dart';

import '../../components/Text.dart';
import '../../components/color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: TAppBar(
        backgroundColor: TColors.backgroundColor,
        title: Text("Account",style: Theme.of(context).textTheme.headlineLarge!.apply(color: TColors.primaryColor,),),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(image: TImages.user,width: 80, height: 80,),
                    TextButton(onPressed: (){}, child: const Text("Change Profile Picture", style: TextStyle(color: TColors.primaryColor),),
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     const CircleAvatar(
              //       backgroundColor: Color(0xff6368d9),
              //       maxRadius: 45,
              //     ),
              //     SizedBox(
              //       width: width * .025,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         BuildText(
              //           text: 'Kerollos harby',
              //           color: AppColor.primeColor,
              //           size: 20,
              //           bold: true,
              //         ),
              //         SizedBox(
              //           height: height * .02,
              //         ),
              //         GestureDetector(
              //           onTap: () {},
              //           child: Container(
              //             height: height * .03,
              //             width: width * .3,
              //             decoration: BoxDecoration(
              //               color: AppColor.secondColor,
              //               borderRadius: BorderRadius.circular(25),
              //             ),
              //             child: Center(
              //               child: BuildText(
              //                 text: "edit Profile",
              //                 color: AppColor.primeColor,
              //                 size: 15,
              //                 bold: true,
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: height * .04,
              // ),
              /// Details
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Divider(),
              SizedBox(height: TSizes.spaceBtwItems,),

              /// Heading Profile Info
              TSectionHeading(title: "Profile Info",showActionButton: false, textColor: TColors.primaryColor,),
              SizedBox(height: TSizes.spaceBtwItems,),
              Container(
                height: height * .225,
                width: width * .9,
                decoration: BoxDecoration(
                    color: AppColor.primeColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amazing!",
                        style: TextStyle(
                            color: AppColor.secondColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height * .1,
                                width: width * .5,
                                child: Center(
                                  child: BuildText(
                                    text: 'You have completed 41 tasks!',
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
                          height: height * .03,
                          width: width * .3,
                          decoration: BoxDecoration(
                            color: AppColor.secondColor,
                            borderRadius: BorderRadius.circular(25),
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
              SizedBox(
                height: height * .03,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: height * .05,
                  width: width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColor.secondColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: AppColor.primeColor,
                        ),
                        SizedBox(
                          width: width * .02,
                        ),
                        BuildText(
                          text: "Account information",
                          color: AppColor.primeColor,
                          size: 15,
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: height * .05,
                  width: width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColor.secondColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_suggest_outlined,
                          color: AppColor.primeColor,
                        ),
                        SizedBox(
                          width: width * .02,
                        ),
                        BuildText(
                          text: "Settings",
                          color: AppColor.primeColor,
                          size: 15,
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: height * .05,
                  width: width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColor.secondColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_sharp,
                          color: AppColor.primeColor,
                        ),
                        SizedBox(
                          width: width * .02,
                        ),
                        BuildText(
                          text: "log out",
                          color: AppColor.primeColor,
                          size: 15,
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
