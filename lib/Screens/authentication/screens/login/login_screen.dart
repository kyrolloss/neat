import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:neat/Screens/authentication/screens/login/widgets/login_form.dart';
import 'package:neat/Screens/authentication/screens/login/widgets/login_header.dart';
import 'package:provider/provider.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/themes/theme_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return  SafeArea(
      child:  Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
                  color:  isDarkMode ? TColors.secondaryColor : TColors.primaryColor,
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




