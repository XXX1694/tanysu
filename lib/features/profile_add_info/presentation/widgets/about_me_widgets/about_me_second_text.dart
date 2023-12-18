import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../l10n/translate.dart';

class AboutMeSecondText extends StatelessWidget {
  const AboutMeSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).about_me_second_text,
      style: GoogleFonts.montserrat(
        color: Colors.black.withOpacity(0.7),
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
