// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/common/constants/language_constants.dart';
import 'package:tanysu/common/widgets/main_button_outlined.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';
import 'package:tanysu/features/login/presentation/pages/login_page.dart';
import 'package:tanysu/main.dart';

import '../../../../common/constants/colors.dart';

class ChooseLanguagePage extends StatefulWidget {
  const ChooseLanguagePage({super.key});

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  late LoginBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LoginBloc>(context);
    bloc.add(GetUserStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) => Scaffold(
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
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    const Spacer(),
                    MainButtonOutlined(
                      text: 'Қазақ',
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
                      text: 'Русский',
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
                      text: 'English',
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
