import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/api/firebase_auth.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';
import 'package:tanysu/features/login/presentation/pages/login_by_email.dart';
import 'package:tanysu/features/main_screen.dart';
import 'package:tanysu/features/registration/presentation/pages/user_main_info_page.dart';
import 'package:tanysu/l10n/translate.dart';

import '../../../../core/widgets/google_button.dart';
import '../../../../core/widgets/main_button_icon.dart';

class ChooseLoginMethod extends StatefulWidget {
  const ChooseLoginMethod({super.key});

  @override
  State<ChooseLoginMethod> createState() => _ChooseLoginMethodState();
}

class _ChooseLoginMethodState extends State<ChooseLoginMethod> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc.add(GetUserStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogedIn) {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        } else if (state is LogedInWithGoogle) {
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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'PANDEYA',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
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
                            builder: (context) => const LoginByEmail(),
                          ),
                        );
                      },
                      icon: 'assets/icons/enter_method/email.svg',
                    ),
                    const SizedBox(height: 40),
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
