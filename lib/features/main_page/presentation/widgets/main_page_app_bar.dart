import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';

class MainPageAppBar extends StatelessWidget {
  const MainPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PANDEYA',
              style: GoogleFonts.montserratAlternates(
                color: mainColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            // GestureDetector(
            //   child: SvgPicture.asset(
            //     'assets/icons/sort.svg',
            //     height: 24,
            //     width: 24,
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const MainFilterPage(),
            //       ),
            //     );
            //     // Navigator.pushNamed(context, '/search');
            //   },
            // ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
