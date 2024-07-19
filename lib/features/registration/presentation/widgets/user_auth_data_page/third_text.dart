import 'package:flutter/material.dart';
import 'package:tanysu/l10n/translate.dart';

class ThirdText extends StatelessWidget {
  const ThirdText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).password_should_be,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.black54,
          ),
    );
  }
}
