import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../l10n/translate.dart';
import '../../../common/widgets/main_button_icon.dart';
import 'agreement.dart';

class SecondSignInBlock extends StatelessWidget {
  const SecondSignInBlock({super.key, required this.callback});
  final Function(bool) callback;
  @override
  Widget build(BuildContext context) {
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
                callback(false);
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
                          onPressed: () {},
                          icon: 'assets/icons/google_icon.svg',
                        )
                      : MainButtonIcon(
                          text: translation(context).sign_in_with_apple,
                          onPressed: () {},
                          icon: 'assets/icons/apple_icon.svg',
                        ),
                  const SizedBox(height: 20),
                  MainButtonIcon(
                    text: translation(context).sign_in_with_phone_number,
                    onPressed: () {},
                    icon: 'assets/icons/phone_icon.svg',
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
