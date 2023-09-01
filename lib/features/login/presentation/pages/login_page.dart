import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/colors.dart';
import '../widgets/main_block.dart';
import '../widgets/second_block.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signUp = false;

  void changeState(bool sign) {
    if (kDebugMode) {
      print(sign);
    }
    signUp = sign;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main_bg.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/app_icon.png'),
          ),
          signUp
              ? SecondSignInBlock(
                  callback: changeState,
                )
              : MainSignInBlock(
                  callback: changeState,
                ),
        ],
      ),
    );
  }
}
