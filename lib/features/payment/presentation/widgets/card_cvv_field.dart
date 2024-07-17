import 'package:flutter/material.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class CardCvvField extends StatefulWidget {
  const CardCvvField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CardCvvField> createState() => _CardCvvFieldState();
}

class _CardCvvFieldState extends State<CardCvvField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        maxLength: 3,
        controller: widget.controller,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          hintText: translation(context).card_cvv,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: mainColor,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
