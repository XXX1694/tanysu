import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class Agreement extends StatelessWidget {
  const Agreement({super.key});
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: translation(context).agreement1,
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: translation(context).agreement2,
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: Colors.black87,
              decorationThickness: 1,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/terms');
              },
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: translation(context).agreement3,
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: translation(context).agreement4,
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: Colors.black87,
              decorationThickness: 1,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/privacy');
              },
          ),
        ],
      ),
    );
  }
}
