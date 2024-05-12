import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.status,
  });
  final String text;
  final VoidCallback? onPressed;
  final String status;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: status == 'active' ? onPressed : null,
      pressedOpacity: status == 'passive' ? 1.0 : 0.54,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: status == 'active'
              ? LinearGradient(
                  colors: [
                    mainColor,
                    secondColor,
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Colors.black12,
                    Colors.black12,
                  ],
                ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: status == 'loading'
              ? Platform.isAndroid
                  ? CircularProgressIndicator(
                      color: secondColor,
                      strokeWidth: 3,
                    )
                  : CupertinoActivityIndicator(
                      color: secondColor,
                    )
              : Text(
                  text,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}
