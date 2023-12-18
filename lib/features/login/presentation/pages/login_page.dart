import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    logOut();
    super.initState();
  }

  void changeState(bool sign) {
    if (kDebugMode) {
      print(sign);
    }
    signUp = sign;
    setState(() {});
  }

  void logOut() async {
    if (kDebugMode) {
      print('loging out');
    }
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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
