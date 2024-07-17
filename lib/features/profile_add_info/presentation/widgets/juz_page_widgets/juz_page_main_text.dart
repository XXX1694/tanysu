import 'package:flutter/material.dart';
import 'package:tanysu/l10n/translate.dart';

class JuzPageMainText extends StatelessWidget {
  const JuzPageMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).juz_main_text,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
