import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class PicMainText extends StatelessWidget {
  const PicMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).pic_main_text,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
      maxLines: 2,
    );
  }
}
