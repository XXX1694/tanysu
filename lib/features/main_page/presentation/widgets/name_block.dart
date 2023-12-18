import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NameBlock extends StatelessWidget {
  const NameBlock({
    super.key,
    required this.name,
    required this.age,
    required this.verified,
  });

  final String name;
  final int age;
  final bool verified;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: name,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' ',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: age.toString(),
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        verified ? const SizedBox(width: 8) : const SizedBox(),
        verified
            ? SvgPicture.asset(
                'assets/icons/verified.svg',
                height: 24,
                width: 24,
              )
            : const SizedBox(),
      ],
    );
  }
}
