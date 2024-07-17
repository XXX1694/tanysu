import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class JobPageMainText extends StatelessWidget {
  const JobPageMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).job_main_text,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
