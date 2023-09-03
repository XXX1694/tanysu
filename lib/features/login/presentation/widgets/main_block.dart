import 'package:flutter/material.dart';

import '../../../../l10n/translate.dart';
import '../../../common/widgets/main_button_filled_white.dart';
import '../../../common/widgets/main_button_outlined.dart';
import 'agreement.dart';

class MainSignInBlock extends StatelessWidget {
  const MainSignInBlock({super.key, required this.callback});
  final Function(bool) callback;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Spacer(),
            const Agreement(),
            const SizedBox(height: 32),
            MainButtonFilledWhite(
              text: translation(context).create_acc,
              onPressed: () {
                Navigator.pushNamed(context, '/get_number');
              },
            ),
            const SizedBox(height: 20),
            MainButtonOutlined(
                text: translation(context).sign_in,
                onPressed: () {
                  callback(true);
                }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
