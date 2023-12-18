import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class ReportSecondText extends StatelessWidget {
  const ReportSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).report_second,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
