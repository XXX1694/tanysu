import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/api/firebase_auth.dart';
import 'package:tanysu/common/widgets/main_button_outlined.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';

import 'package:tanysu/features/login/presentation/pages/login_by_email.dart';
import 'package:tanysu/features/main_screen.dart';
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
  late LoginBloc bloc;
  late RegistrationBloc bloc1;
  bool isLoading = false;
  @override
  void initState() {
    bloc = BlocProvider.of<LoginBloc>(context);
    bloc1 = BlocProvider.of<RegistrationBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return SafeArea(
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
                      ? BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LogedIn) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                                (route) => false,
                              );
                            } else if (state is LoginError) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserMainInfoPage(
                                    email: result!.email!,
                                    password: 'Qweasdzxc1!',
                                  ),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is LogingIn) {
                              return const MainButtonOutlinedLoading();
                            } else {
                              return MainButtonIcon(
                                text: translation(context).sign_in_with_google,
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  FirebaseService service = FirebaseService();
                                  try {
                                    await service.signOutFromGoogle();
                                    await service.signInwithGoogle();
                                    if (result!.email != null) {
                                      if (kDebugMode) {
                                        print(result.email!);
                                      }
                                      bloc.add(
                                        LogIn(
                                          email: result.email!,
                                          password: 'Qweasdzxc1!',
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if (e is FirebaseAuthException) {
                                      if (kDebugMode) {
                                        print(e.message!);
                                      }
                                    }
                                  }
                                },
                                icon: 'assets/icons/google_icon.svg',
                              );
                            }
                          },
                        )
                      : const SizedBox(),
                  Platform.isAndroid
                      ? const SizedBox(height: 20)
                      : const SizedBox(),
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
    );
  }
}
