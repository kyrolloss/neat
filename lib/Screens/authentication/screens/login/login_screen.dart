import 'package:flutter/material.dart';
import 'package:neat/Screens/authentication/screens/login/widgets/login_form.dart';
import 'package:neat/Screens/authentication/screens/login/widgets/login_header.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utlis/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child:  Scaffold(
        backgroundColor: TColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo
              LoginHeader(),

              /// Form
              LoginForm(),
            ],
          ),
          ),
        ),
      ),
    );
  }
}




