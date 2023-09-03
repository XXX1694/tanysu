import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../l10n/translate.dart';

class CreateProfileMainText extends StatelessWidget {
  const CreateProfileMainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).create_profile_main_text,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
