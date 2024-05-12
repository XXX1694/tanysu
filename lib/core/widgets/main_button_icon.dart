import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';

class MainButtonIcon extends StatelessWidget {
  const MainButtonIcon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });
  final String text;
  final String icon;
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
          color: Colors.transparent,
          border: Border.all(
            color: mainColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 13),
                  SvgPicture.asset(
                    icon,
                    height: 24,
                    width: 24,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Center(
              child: Text(
                text,
                style: GoogleFonts.montserrat(
                  color: mainColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
