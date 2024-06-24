import 'package:flutter/material.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';

class Terms extends StatelessWidget {
   Terms({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: AppColor.primeColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title:  Text('Terms of Use', style: TextStyle(color: Colors.white),),

      ),
      backgroundColor: AppColor.secondColor,
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                BuildText(
                  maxLines: 150,
                  text: """
 Neat Task Terms of Use

You agree to use Neat Task for lawful purposes and keep your account and password confidential.\n
We collect and store your email address, password, and usage data, and may use it to improve the app.\n
We may send you notifications via email, but you can opt-out.\n
We may integrate with third-party services, but we don't store your passwords or sensitive information.\n
We don't sell your email addresses or personal information to third parties.\n
We're not liable for losses or damages resulting from using the app.\n
You can terminate your account at any time, and we may terminate it for violation of these terms.\n
These terms are governed by the laws of [State/Country].\n
Neat Task Privacy Policy\n

We collect your email address, password, and usage data, and use it to improve the app and provide customer support.\n
We don't sell your email addresses or personal information to third parties, but we may share it with partners and affiliates.\n
We use industry-standard encryption and secure servers to protect your data.\n
You have the right to request access to your personal information.\n
We reserve the right to modify these terms and policies at any time.\n
By using Neat Task, you agree to these terms and policies """,
                  bold: true,
                  color: AppColor.primeColor,
                  size: 15,
                  letterSpacing: 1.25,
                  wordSpacing: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
