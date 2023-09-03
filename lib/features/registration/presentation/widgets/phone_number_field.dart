import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/common/widgets/colors.dart';
import 'package:tanysu/l10n/translate.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.montserrat(
        color: Colors.black87,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: translation(context).phone_number,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: secondColor,
          ),
        ),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [maskFormatter],
    );
  }
}

var maskFormatter = MaskTextInputFormatter(
  mask: '+7 (###) ###-##-##',
  filter: {
    "#": RegExp(r'[0-9]'),
  },
);
