import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';

class MainButtonOutlined extends StatelessWidget {
  const MainButtonOutlined({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onPressed,
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
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              color: mainColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class MainButtonOutlinedLoading extends StatelessWidget {
  const MainButtonOutlinedLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {},
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Center(
          child: CupertinoActivityIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MainButtonOutlinedWithIcon extends StatelessWidget {
  const MainButtonOutlinedWithIcon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.iconUrl,
  });
  final String text;
  final VoidCallback? onPressed;
  final String iconUrl;
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
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              color: mainColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
