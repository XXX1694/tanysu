import 'package:appinio_swiper/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfileInfoBlock extends StatelessWidget {
  const ProfileInfoBlock({
    super.key,
    required this.coins,
    required this.followers,
    required this.controller,
  });
  final int followers;
  final int coins;
  final AppinioSwiperController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
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
            )
          ],
        ),
        const SizedBox(width: 70),
        Column(
          children: [
            Text(
              '${coins}K',
              style: GoogleFonts.montserrat(
                color: mainColor70,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Text(
              translation(context).coins,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            )
          ],
        ),
        const SizedBox(width: 70),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: SvgPicture.asset(
            'assets/icons/like_profile.svg',
            height: 36,
            width: 36,
          ),
          onPressed: () async {
            Navigator.pop(context);
            await Future.delayed(const Duration(milliseconds: 200));
            controller.swipeRight();
          },
        ),
      ],
    );
  }
}
