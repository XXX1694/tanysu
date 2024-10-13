import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerificationIcon extends StatelessWidget {
  const VerificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SvgPicture.asset(
        'assets/icons/not_verified.svg',
        height: 28,
        width: 28,
      ),
    );
  }
}
