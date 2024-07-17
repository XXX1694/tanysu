import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class AboutMeMainText extends StatelessWidget {
  const AboutMeMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).about_me_main_text,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
