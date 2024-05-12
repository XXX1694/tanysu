import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/colors.dart';
import '../../../login/presentation/widgets/main_block.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Text(
              'tanysu',
              style: GoogleFonts.montserratAlternates(
                  color: mainColor, fontWeight: FontWeight.w700, fontSize: 72),
            ),
          ),
          SvgPicture.asset(
            'assets/background/main_background_pattern.svg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const MainSignInBlock(),
        ],
      ),
    );
  }
}
