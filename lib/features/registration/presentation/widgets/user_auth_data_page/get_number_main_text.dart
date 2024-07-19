import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class GetNumberMainText extends StatelessWidget {
  const GetNumberMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).get_number_main_text,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
