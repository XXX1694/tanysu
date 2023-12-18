import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../l10n/translate.dart';

class PicMainText extends StatelessWidget {
  const PicMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).pic_main_text,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
