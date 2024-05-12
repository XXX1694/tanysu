import 'package:flutter/material.dart';

import '../../../../l10n/translate.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_button_outlined.dart';
import '../../../registration/presentation/pages/choose_registration_method.dart';
import '../pages/choose_login_method.dart';
import 'agreement.dart';

class MainSignInBlock extends StatelessWidget {
  const MainSignInBlock({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),
            const Agreement(),
            const SizedBox(height: 32),
            MainButton(
              text: translation(context).create_acc,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseRegistrationMethod(),
                  ),
                );
              },
              status: 'active',
            ),
            const SizedBox(height: 20),
            MainButtonOutlined(
              text: translation(context).sign_in,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseLoginMethod(),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
