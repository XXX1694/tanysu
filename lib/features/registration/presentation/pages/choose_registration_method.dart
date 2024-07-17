import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/api/firebase_auth.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';
import 'package:tanysu/features/main_screen.dart';
import 'package:tanysu/features/registration/presentation/pages/user_auth_data_page.dart';
import 'package:tanysu/features/registration/presentation/pages/user_main_info_page.dart';
import 'package:tanysu/l10n/translate.dart';

import '../../../../core/widgets/google_button.dart';
import '../../../../core/widgets/main_button_icon.dart';

class ChooseRegistrationMethod extends StatefulWidget {
  const ChooseRegistrationMethod({super.key});

  @override
  State<ChooseRegistrationMethod> createState() =>
      _ChooseRegistrationMethodState();
}

class _ChooseRegistrationMethodState extends State<ChooseRegistrationMethod> {
  late LoginBloc _loginBloc;
  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogedInWithGoogle) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
            (route) => false,
          );
        } else if (state is LoginErrorWithGoogle) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => UserMainInfoPage(
                email: result != null ? result.email ?? '' : '',
                password: 'Qweasdzxc1!',
              ),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: Text(
                'tanysu',
                style: GoogleFonts.montserratAlternates(
                  color: mainColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 72,
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    Platform.isAndroid
                        ? GoogleButton(

                            onPressed: () async {
                              FirebaseService service = FirebaseService();
                              try {
                                // await service.signOutFromGoogle();
                                await service.signInwithGoogle();
                                if (result != null) {
                                  if (result.email != null) {
                                    _loginBloc.add(
                                      LogInWithGoogle(
                                        email: result.email ?? '',
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                if (e is FirebaseAuthException) {}
                              }
                            },

                          )
                        : MainButtonIcon(
                            text: translation(context).with_apple,
                            onPressed: () {},
                            icon: 'assets/icons/enter_method/apple.svg',
                          ),
                    const SizedBox(height: 20),
                    MainButtonIcon(
                      text: translation(context).with_email,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserAuthDataPage(),
                          ),
                        );
                      },
                      icon: 'assets/icons/enter_method/email.svg',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
