import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../l10n/translate.dart';

class JobField extends StatelessWidget {
  const JobField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: translation(context).job_field_text,
        hintStyle: GoogleFonts.montserrat(
          color: Colors.black87,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: mainColor,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
