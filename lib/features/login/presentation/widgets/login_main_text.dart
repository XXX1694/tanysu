import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../l10n/translate.dart';

class LoginMainText extends StatelessWidget {
  const LoginMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).login_main_text,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
