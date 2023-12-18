import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RuBlock extends StatelessWidget {
  const RuBlock({super.key, required this.ru});
  final String ru;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/oyu.svg',
          width: 20,
        ),
        const SizedBox(width: 8),
        Text(
          ru,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
