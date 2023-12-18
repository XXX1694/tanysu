import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../l10n/translate.dart';

class AboutMeMainText extends StatelessWidget {
  const AboutMeMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).about_me_main_text,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
