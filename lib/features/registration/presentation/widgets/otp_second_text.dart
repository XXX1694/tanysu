import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPSecondText extends StatelessWidget {
  const OTPSecondText({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Text(
      phoneNumber,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
