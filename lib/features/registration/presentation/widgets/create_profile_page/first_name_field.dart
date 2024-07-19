import 'package:flutter/material.dart';

import '../../../../../l10n/translate.dart';
import '../../../../../core/constants/colors.dart';

class FirstNameField extends StatelessWidget {
  const FirstNameField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          hintText: translation(context).enter_first_name,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: mainColor,
            ),
          ),
        ),
        keyboardType: TextInputType.name,
      ),
    );
  }
}
