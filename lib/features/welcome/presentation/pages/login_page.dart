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
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'pande',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: mainColor,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      TextSpan(
                        text: 'YA!',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const MainSignInBlock(),
            ],
          ),
        ),
      ),
    );
  }
}
