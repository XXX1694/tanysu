import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class JuzPageSecondText extends StatelessWidget {
  const JuzPageSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).juz_second_text,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
