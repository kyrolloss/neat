import 'package:flutter/material.dart';


class buildTextFormField extends StatelessWidget {
  late TextEditingController controller;
  late String hintText;
   IconData? prefixIcon;
  Widget? suffixIcon;
  String? Function(String?)? valid;
  TextInputType? keyboardType;
  bool? isPassword;
  Color backgroundColor;

  buildTextFormField({
    required this.controller,
    required this.hintText,
     this.prefixIcon,
     this.suffixIcon,
     this.valid,
     this.keyboardType,
     this.isPassword,
    required  this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(



      autocorrect: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style:const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      validator: valid,
      keyboardType: keyboardType,
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        errorStyle: const TextStyle(fontWeight: FontWeight.bold),
        hintText: hintText,

        suffixIcon: suffixIcon,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Icon(
            prefixIcon,

          ),
        ),
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(

              color: backgroundColor


          ),
          borderRadius: BorderRadius.circular(15),

        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: backgroundColor


          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(

          borderSide: BorderSide(
              color: backgroundColor

          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
