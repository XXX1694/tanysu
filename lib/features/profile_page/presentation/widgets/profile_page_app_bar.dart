import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/constants/colors.dart';

class ProfilePageAppBar extends StatelessWidget {
  const ProfilePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 54,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'tanysu',
                style: GoogleFonts.montserrat(
                  color: secondColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/notification');
                },
                child: SvgPicture.asset(
                  'assets/icons/ring.svg',
                  height: 24,
                  width: 24,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
                child: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
