import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class AboutMeSecondText extends StatelessWidget {
  const AboutMeSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).about_me_second_text,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.black54,
          ),
    );
  }
}
