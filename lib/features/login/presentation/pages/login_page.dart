import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/features/login/presentation/widgets/second_block.dart';

import '../../../../common/constants/colors.dart';
import '../widgets/main_block.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signUp = false;

  @override
  void initState() {
    super.initState();
  }

  void changeState(bool sign) {
    setState(() {
      signUp = sign;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/main_bg.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            // child: Image.asset('assets/images/app_icon.png'),
            child: SvgPicture.asset('assets/icons/app_icon.svg'),
          ),
          // const MainSignInBlock(),
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
