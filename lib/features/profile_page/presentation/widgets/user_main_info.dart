import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({
    super.key,
    required this.followers,
    required this.coins,
  });

  final int followers;
  final int coins;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$followers',
              style: GoogleFonts.montserrat(
                color: mainColor70,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Text(
              translation(context).followers,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$coins',
              style: GoogleFonts.montserrat(
                color: mainColor70,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Text(
              translation(context).taken,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 39,
            width: 119,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                translation(context).buy_a_coin,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
