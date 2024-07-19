import 'package:flutter/material.dart';
import 'package:tanysu/l10n/translate.dart';

class ReportSecondText extends StatelessWidget {
  const ReportSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).report_second,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.black54,
          ),
    );
  }
}
