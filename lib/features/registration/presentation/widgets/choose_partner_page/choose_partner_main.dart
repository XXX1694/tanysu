import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';

class ChoosePartnerMain extends StatelessWidget {
  const ChoosePartnerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).choose_partner_main,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
