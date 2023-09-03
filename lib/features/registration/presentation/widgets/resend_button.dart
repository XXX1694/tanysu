import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      child: Text(
        translation(context).resend,
        style: GoogleFonts.montserrat(
          color: Colors.green,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () {},
    );
  }
}
