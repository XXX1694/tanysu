import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: mainColor,
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
                    'assets/icons/enter_method/google.svg',
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Center(
              child: Text(
                'Google',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
