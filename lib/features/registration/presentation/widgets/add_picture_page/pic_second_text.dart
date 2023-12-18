import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../l10n/translate.dart';

class PicSecondText extends StatelessWidget {
  const PicSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).pic_second_text,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
