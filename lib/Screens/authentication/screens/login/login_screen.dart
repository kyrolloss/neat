import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:neat/Screens/authentication/screens/login/widgets/login_form.dart';
import 'package:neat/Screens/authentication/screens/login/widgets/login_header.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utlis/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:  Scaffold(
        backgroundColor: TColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo
              const LoginHeader(),

              /// Form
              DottedBorder(
                dashPattern: const [8,6],
                  strokeWidth: 2,
                  color: TColors.primaryColor,
                  child: const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: LoginForm(),
                  )),
            ],
          ),
          ),
        ),
      ),
    );
  }
}




