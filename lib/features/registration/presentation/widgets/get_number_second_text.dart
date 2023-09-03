import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../l10n/translate.dart';

class GetNumberSecondText extends StatelessWidget {
  const GetNumberSecondText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).get_number_second_text,
      style: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
