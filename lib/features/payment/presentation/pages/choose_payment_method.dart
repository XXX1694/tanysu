import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/l10n/translate.dart';

Future showBlock(BuildContext context, int coinNumber, int price) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              translation(context).get_coins,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 32),
            const SizedBox(height: 40),
            MainButton(
              text: '${translation(context).pay} ₸ $price',
              onPressed: () {},
              status: 'active',
            ),
          ],
        ),
      );
    },
  );
}
