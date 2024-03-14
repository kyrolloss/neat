import 'package:flutter/material.dart';
import 'package:neat/common/widgets/appbar/appbar.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:neat/utlis/constants/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: TAppBar(
        backgroundColor: TColors.backgroundColor,
        title: Text("Notifications", style: TextStyle(color: TColors.primaryColor,fontWeight: FontWeight.bold),),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0 , right: 22.5,left: 22.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: height*.02,),
              BuildText(text: 'Yesterday' , color: AppColor.primeColor,size: 17.5,bold: false,),
              SizedBox(
                height: height*.45,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: height * .13,
                        width: width * .8,
                        decoration: BoxDecoration(
                          color: AppColor.secondColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildText(
                                text: 'college stuff',
                                color: AppColor.primeColor,
                                size: 15,
                              ),

                              BuildText(
                                text: 'Design And Documentation meeting',
                                color: AppColor.primeColor,
                                size: 17.5,
                                bold: true,
                              ),

                              Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: AppColor.primeColor,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: width * .02,
                                  ),
                                  BuildText(
                                    text: '15.00 pm - 16.00',
                                    color: AppColor.primeColor,
                                    size: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              ,
              BuildText(text: 'Today' , color: AppColor.primeColor,size: 17.5,bold: false,),
              SizedBox(
                height: height*.8,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),

                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: height * .13,
                        width: width * .8,
                        decoration: BoxDecoration(
                          color: AppColor.secondColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildText(
                                text: 'college stuff',
                                color: AppColor.primeColor,
                                size: 15,
                              ),

                              BuildText(
                                text: 'Design And Documentation meeting',
                                color: AppColor.primeColor,
                                size: 17.5,
                                bold: true,
                              ),

                              Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: AppColor.primeColor,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: width * .02,
                                  ),
                                  BuildText(
                                    text: '15.00 pm - 16.00',
                                    color: AppColor.primeColor,
                                    size: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
