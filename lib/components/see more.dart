import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeeMoreButton extends StatelessWidget {
  final String mainText;
  final String additionalText;
  final String alertName;


  const SeeMoreButton({
    required this.mainText,
    required this.additionalText,
    required this.alertName,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          // عرض النص الأساسي
          mainText,
          // اقتصار النص لعرض أقل
          overflow: TextOverflow.ellipsis,
          maxLines: 2, // يمكن تعديل هذا الرقم حسب الحاجة
          style: TextStyle(fontSize: 20,color: Colors.red , fontWeight: FontWeight.bold,),
        ),
        SizedBox(height: 8), // مسافة بين النص الرئيسي وزر "see more"
        InkWell(
          onTap: () {
            // يمكنك هنا إظهار مثلاً AlertDialog يحتوي على النص الإضافي
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(alertName),
                  content: Text(additionalText),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            'See more',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}