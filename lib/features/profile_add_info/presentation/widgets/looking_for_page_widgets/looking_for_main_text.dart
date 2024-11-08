import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../l10n/translate.dart';

class LookingForMainText extends StatelessWidget {
  const LookingForMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).looking_for_main_text,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
