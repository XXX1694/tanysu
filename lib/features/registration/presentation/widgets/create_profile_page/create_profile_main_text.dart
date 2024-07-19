import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class CreateProfileMainText extends StatelessWidget {
  const CreateProfileMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).create_profile_main_text,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
