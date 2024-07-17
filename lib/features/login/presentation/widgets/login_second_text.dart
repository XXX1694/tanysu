import 'package:flutter/material.dart';

import '../../../../l10n/translate.dart';

class LoginSecondText extends StatelessWidget {
  const LoginSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).login_second_text,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.black54,
          ),
    );
  }
}
