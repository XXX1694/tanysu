import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../l10n/translate.dart';
import '../../../common/widgets/colors.dart';

class GenderField extends StatelessWidget {
  const GenderField({super.key, required this.controller});
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
        hintText: translation(context).enter_gender,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: secondColor,
          ),
        ),
      ),
      keyboardType: TextInputType.name,
    );
  }
}
