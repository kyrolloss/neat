import 'package:flutter/material.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';

class toDoTab extends StatelessWidget {
  const toDoTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height * .125,
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
    );
  }
}
