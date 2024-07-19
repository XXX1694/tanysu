import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class GetNumberSecondText extends StatelessWidget {
  const GetNumberSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).get_number_second_text,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.black87,
          ),
    );
  }
}
