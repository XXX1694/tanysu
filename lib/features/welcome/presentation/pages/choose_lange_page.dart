// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/constants/language_constants.dart';
import 'package:tanysu/core/widgets/main_button_outlined.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';
import 'package:tanysu/features/welcome/presentation/pages/login_page.dart';
import 'package:tanysu/main.dart';

class ChooseLanguagePage extends StatefulWidget {
  const ChooseLanguagePage({super.key});

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc.add(GetUserStatus());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
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
                    MainButtonOutlined(
                      text: 'ҚАЗАҚША',
                      onPressed: () async {
                        Locale locale = await setLocale('kk');
                        MainApp.setLocale(context, locale);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    MainButtonOutlined(
                      text: 'РУССКИЙ',
                      onPressed: () async {
                        Locale locale = await setLocale('ru');
                        MainApp.setLocale(context, locale);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    MainButtonOutlined(
                      text: 'ENGLISH',
                      onPressed: () async {
                        Locale locale = await setLocale('en');
                        MainApp.setLocale(context, locale);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      listener: (context, state) {
        if (state is LogedIn) {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        }
      },
    );
  }
}
