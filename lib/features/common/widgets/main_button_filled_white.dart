import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/common/widgets/colors.dart';

class MainButtonFilledWhite extends StatelessWidget {
  const MainButtonFilledWhite({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              color: secondColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
