import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class SchoolPageMainText extends StatelessWidget {
  const SchoolPageMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).school_page_main_text,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
