// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/core/constants/language_constants.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        centerTitle: true,
        title: Text(
          translation(context).change_language,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Қазақша',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const Spacer(),
                  ],
                ),
                onPressed: () async {
                  Locale locale = await setLocale('kk');
                  MainApp.setLocale(context, locale);
                },
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Русский',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const Spacer(),
                  ],
                ),
                onPressed: () async {
                  Locale locale = await setLocale('ru');
                  MainApp.setLocale(context, locale);
                },
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'English',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const Spacer(),
                  ],
                ),
                onPressed: () async {
                  Locale locale = await setLocale('en');
                  MainApp.setLocale(context, locale);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
