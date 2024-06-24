import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neat/components/color.dart';
import 'package:neat/components/components.dart';

import '../../../../../Admin Screens/Main Layout.dart';
import '../../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../utlis/constants/image_strings.dart';
import '../../../../../utlis/constants/text_strings.dart';
import '../../../../MainLayout.dart';


class SubscriptionPage extends StatefulWidget {
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final String? title;
  final String? type;
  final bool  auth ;

  const SubscriptionPage({Key? key, this.email, this.password, this.name, this.phone, this.title, this.type, required this.auth}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  List<String> freeFeatures = [
    "task management",
    "task status",
    "chat",
    "attach file",
    "notification",
    "calendar",
    "unlimited users",
    "dark mode",
  ];

  List<String> premiumFeatures = [
    "task management",
    "task status",
    "chat",
    "attach file",
    "notification",
    "calendar",
    "unlimited users",
    "performance analysis",
    "see your evaluation",
    "tracking tasks evaluation",
    "dark mode",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primeColor,
            title: Text(
              'Subscription Plans', style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SubscriptionContainer(
                      title: 'Free',
                      color: Colors.blue[100]!,
                      buttonText: 'try Free',
                      features: freeFeatures,
                      onPressed: () {
                        if (widget.auth == true){                        AppCubit.get(context).Register(email: widget.email, password: widget.password, name: widget.name, phone: widget.phone, title: widget.title, type: widget.type , premium:cubit.premium);
                        navigateTo(context,  SuccessScreen(
                          image: TImages.staticSuccessIllustration2,
                          title: TText.yourAccountCreatedTitle,
                          subTitle: TText.yourAccountCreatedSubTitle,
                          type: widget.type!,
                          onPressed: () {
                            if (widget.type == 'User')
                            {navigateToToFinish(context,  MainLayout(uid: AppCubit.get(context).id));}
                            else if (widget.type =='Admin')
                            {
                              navigateToToFinish(context,  AdminMainLayout(uid: AppCubit.get(context).id));
                            }

                          },
                        ));
                        }
                        else {
                          widget.type == 'User' ? navigateTo(context, MainLayout(uid: '')) : navigateTo(context, AdminMainLayout(uid: ''));
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: SubscriptionContainer(
                      title: 'Premium',
                      color: Colors.yellow[100]!,
                      buttonText: 'try Premium',
                      features: premiumFeatures,
                      onPressed: () {
                        cubit.premium = true;
                        AppCubit.get(context).Register(email: widget.email!, password: widget.password!, name: widget.name!, phone: widget.phone!, title: widget.title!, type: widget.type! , premium:cubit.premium);
                        navigateTo(context,  SuccessScreen(
                          image: TImages.staticSuccessIllustration2,
                          title: TText.yourAccountCreatedTitle,
                          subTitle: TText.yourAccountCreatedSubTitle,
                          type: widget.type!,
                          onPressed: () {
                            if (widget.type == 'User')
                            {navigateToToFinish(context,  MainLayout(uid: AppCubit.get(context).id));}
                            else if (widget.type =='Admin')
                            {
                              navigateToToFinish(context,  AdminMainLayout(uid: AppCubit.get(context).id));
                            }

                          },
                        ));

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SubscriptionContainer extends StatelessWidget {
  final String title;
  final Color color;
  final String buttonText;
  final List<String> features;
  final VoidCallback onPressed;

  const SubscriptionContainer({
    required this.title,
    required this.color,
    required this.buttonText,
    required this.features,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
            ),
            child: Text(buttonText),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: features.map((feature) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}