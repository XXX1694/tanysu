import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../l10n/translate.dart';

class SchoolPageMainText extends StatelessWidget {
  const SchoolPageMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).school_page_main_text,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
