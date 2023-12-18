// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/language_constants.dart';
import 'package:tanysu/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tanysu/l10n/translate.dart';
import 'package:tanysu/main.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  late SettingsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          translation(context).change_language,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.black26,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Kz',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                onPressed: () async {
                  Locale locale = await setLocale('kk');
                  MainApp.setLocale(context, locale);
                },
              ),
              const Divider(color: Colors.black26),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Ru',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                onPressed: () async {
                  Locale locale = await setLocale('ru');
                  MainApp.setLocale(context, locale);
                },
              ),
              const Divider(color: Colors.black26),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'En',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                onPressed: () async {
                  Locale locale = await setLocale('en');
                  MainApp.setLocale(context, locale);
                },
              ),
              const Divider(color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}
