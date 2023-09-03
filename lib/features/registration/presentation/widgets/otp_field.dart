import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPField extends StatelessWidget {
  const OTPField({super.key, required this.otpController});
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      showCursor: false,
      separatorBuilder: (index) => const Spacer(),
      controller: otpController,
      defaultPinTheme: PinTheme(
        height: 43,
        width: 43,
        textStyle: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
