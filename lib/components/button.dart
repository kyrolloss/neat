import 'package:flutter/material.dart';


import 'Text.dart';
import 'color.dart';
class BuildButton extends StatelessWidget{
  var height;
  var width;
  var text;
  var function;
  var color;
   double? margin ;
   double? border;

  BuildButton({
    required this.height,
    required this.width,
    required this.text,
    required this.function,
    this.color,
    this.margin,
     this.border





  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border!)

      ),

      child: MaterialButton(
        color: color,
        onPressed: function,
        child: BuildText(
          text: text,





        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
//
//
// import 'Text.dart';
// import 'color.dart';
// class  BuildButton extends StatefulWidget {
//   var height ;
//   var width;
//   var text;
//   late var function;
//   Color? color;
//   final Color TextColor;
//   bool? TextColorBold;
//   double? margin ;
//
//
//
//
//
//
//
//   BuildButton(
//       {
//
//         required this.text,
//         required this.function,
//         required this.width,
//         required this.height,
//         Color? this.color,
//         required this.TextColor,
//         bool? this.TextColorBold,
//         double? this.margin
//
//
//
//
//
//
//       });
//
//   @override
//   State<BuildButton> createState() => _BuildButtonState();
// }
//
// class _BuildButtonState extends State<BuildButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(margin!),
//
//       height:height,
//       width: width,
//       child: MaterialButton(
//         onPressed: function,
//         child: BuildText(
//
//           text: widget.text,
//
//           bold: true,
//         ),
//         color: color != null? color: AppColor.primeColor,
//       ),
//     );
//   }
// }
