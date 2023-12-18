import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';

import 'package:tanysu/features/login/presentation/pages/login_by_email.dart';
import 'package:tanysu/features/registration/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:tanysu/features/registration/presentation/pages/user_main_info_page.dart';

import '../../../../l10n/translate.dart';
import '../../../../common/widgets/main_button_icon.dart';
import 'agreement.dart';

class SecondSignInBlock extends StatefulWidget {
  const SecondSignInBlock({
    super.key,
    required this.callback,
  });
  final Function(bool) callback;

  @override
  State<SecondSignInBlock> createState() => _SecondSignInBlockState();
}

class _SecondSignInBlockState extends State<SecondSignInBlock> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late LoginBloc bloc;
  late RegistrationBloc bloc1;

  User? user;

  void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider googleAuthProbider = GoogleAuthProvider();
      await _auth.signInWithProvider(googleAuthProbider);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    bloc = BlocProvider.of<LoginBloc>(context);
    bloc1 = BlocProvider.of<RegistrationBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _auth.authStateChanges().listen((event) {
      if (kDebugMode) {
        print(event);
        print(event?.email ?? '');
      }

      user = event;
      if (event != null) {
        if (event.email!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserMainInfoPage(
                email: event.email!,
                password: '123Qweasdzxc!',
              ),
            ),
          );
        } else {}
      }
    });
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is UserCreated) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserMainInfoPage(
                  email: user!.email!,
                  password: 'Qweasdzxc1!',
                ),
              ));
        } else if (state is UserCreateError) {
          if (user!.email != null) {
            bloc.add(
              LogIn(email: user!.email!, password: 'Qweasdzxc1!'),
            );
          }
        }
      },
      builder: (context, state) => SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  widget.callback(false);
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Spacer(),
                    const Agreement(),
                    const SizedBox(height: 32),
                    Platform.isAndroid
                        ? MainButtonIcon(
                            text: translation(context).sign_in_with_google,
                            onPressed: _handleGoogleSignIn,
                            icon: 'assets/icons/google_icon.svg',
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    MainButtonIcon(
                      text: translation(context).sign_in_with_phone_number,
                      onPressed: () {
                        widget.callback(true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginByEmail(),
                          ),
                        );
                      },
                      icon: 'assets/icons/mail.svg',
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
