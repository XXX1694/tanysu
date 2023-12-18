import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../l10n/translate.dart';

class ChoosePartnerMain extends StatelessWidget {
  const ChoosePartnerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translation(context).choose_partner_main,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
