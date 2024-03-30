import 'package:flutter/material.dart';

import '../../../../../../utlis/constants/colors.dart';
import '../../../../../../utlis/constants/sizes.dart';
import '../../../../../../utlis/constants/text_strings.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {
  const TermsAndConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 5, height: 5,
          child: Checkbox(value: true, onChanged: (value){}),
        ),

        const SizedBox(width: TSizes.spaceBtwItems,),

        Text.rich(TextSpan(
            children: [
              TextSpan(
                  text: '${TText.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall
              ),
              TextSpan(
                text: TText.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.primaryColor,
                    decoration: TextDecoration.underline
                ),

              ),

              TextSpan(
                  text: ' ${TText.and}',
                  style: Theme.of(context).textTheme.bodySmall
              ),

              TextSpan(
                  text: ' ${TText.termsOfUse} ',
                  style:
                  Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.primaryColor,
                      decoration: TextDecoration.underline
                  )
              ),
            ]
        ))
      ],
    );
  }
}