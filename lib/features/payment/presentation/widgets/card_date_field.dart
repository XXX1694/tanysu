import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class CardDateField extends StatefulWidget {
  const CardDateField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CardDateField> createState() => _CardDateFielddState();
}

class _CardDateFielddState extends State<CardDateField> {
  @override
  void initState() {
    super.initState();
  }

  final _expiryDateFormatter = MaskedTextInputFormatter(mask: '00/00');
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: TextField(
        maxLength: 5,
        controller: widget.controller,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          hintText: translation(context).card_date,
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
        inputFormatters: [_expiryDateFormatter],
      ),
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;

  MaskedTextInputFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length) {
      var text = _applyMask(newValue.text, mask);
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
    return newValue;
  }

  String _applyMask(String value, String mask) {
    mask.replaceAll('0', '');
    var result = '';
    var maskIndex = 0;
    for (var i = 0; i < value.length; i++) {
      if (maskIndex >= mask.length) break;
      if (mask[maskIndex] == '0') {
        result += value[i];
        maskIndex++;
      } else {
        result += mask[maskIndex];
        result += value[i];
        maskIndex++;
      }
    }
    return result;
  }
}
