import 'package:flutter/material.dart';

import '../../../../l10n/translate.dart';

class LoginMainText extends StatelessWidget {
  const LoginMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).login,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
