import 'package:flutter/material.dart';
import 'package:neat/Screens/authentication/terms/terms.dart';
import 'package:neat/components/components.dart';

import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';

class TermsAndConditionsCheckbox extends StatefulWidget {
  const TermsAndConditionsCheckbox({
    super.key,
  });

  @override
  State<TermsAndConditionsCheckbox> createState() =>
      _TermsAndConditionsCheckboxState();
}

class _TermsAndConditionsCheckboxState
    extends State<TermsAndConditionsCheckbox> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: TColors.secondaryColor,
          activeColor: TColors.primaryColor,
          side: BorderSide(color: TColors.primaryColor),
          shape: RoundedRectangleBorder(side: BorderSide(color: TColors.primaryColor, ),
              borderRadius: BorderRadius.circular(4)),
            value: status,
            onChanged: (value) {
              setState(() {
                status = value!;
              });
            }),

        Text.rich(
            TextSpan(children: [
          TextSpan(
              text: '${TText.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
            text: TText.privacyPolicy,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: TColors.primaryColor,
                decoration: TextDecoration.underline),
          ),
          TextSpan(
              text: ' ${TText.and}',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: ' ${TText.termsOfUse} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: TColors.primaryColor,
                  decoration: TextDecoration.underline)),
        ]))
      ],
    );
  }
}
