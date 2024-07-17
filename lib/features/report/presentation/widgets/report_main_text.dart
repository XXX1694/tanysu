import 'package:flutter/material.dart';
import 'package:tanysu/l10n/translate.dart';

class ReportMainText extends StatelessWidget {
  const ReportMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).write_reason,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
