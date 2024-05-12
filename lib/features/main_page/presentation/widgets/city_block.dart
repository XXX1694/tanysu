import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';

class CityBlock extends StatelessWidget {
  const CityBlock({super.key, required this.city});
  final String city;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: greenColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              city,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
