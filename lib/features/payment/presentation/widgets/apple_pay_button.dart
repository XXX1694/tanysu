import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class ApplePayButton extends StatelessWidget {
  const ApplePayButton({
    super.key,
    required this.price,
  });
  final int price;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.black54,
          //   width: 1,
          // ),
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 54,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              translation(context).card,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/coin.svg',
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '$price',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
