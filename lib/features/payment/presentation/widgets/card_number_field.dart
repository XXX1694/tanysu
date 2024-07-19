import 'package:flutter/material.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class CardNumberField extends StatefulWidget {
  const CardNumberField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<CardNumberField> {
  String _previousText = '';
  @override
  void initState() {
    widget.controller.addListener(() {
      if (widget.controller.text.length > _previousText.length) {
        if (widget.controller.text.length == 4 ||
            widget.controller.text.length == 9 ||
            widget.controller.text.length == 14) {
          widget.controller.text = '${widget.controller.text} ';
          widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length));
        }
      }
      _previousText = widget.controller.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        maxLength: 19,
        controller: widget.controller,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          hintText: translation(context).card_number,
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
