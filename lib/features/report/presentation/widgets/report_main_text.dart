import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class ReportMainText extends StatelessWidget {
  const ReportMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).write_reason,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
