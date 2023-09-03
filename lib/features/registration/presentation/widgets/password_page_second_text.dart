import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../l10n/translate.dart';

class PasswordPageSecondText extends StatelessWidget {
  const PasswordPageSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Text(
        translation(context).password_page_second_text,
        style: GoogleFonts.montserrat(
          color: Colors.black54,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
