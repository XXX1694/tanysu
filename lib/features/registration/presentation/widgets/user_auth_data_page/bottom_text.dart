import 'package:flutter/material.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class RegistrationBottomText extends StatelessWidget {
  const RegistrationBottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          translation(context).already_have_acc,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.black54,
              ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/login',
            );
          },
          child: Text(
            " ${translation(context).sign_in}",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: mainColor,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ],
    );
  }
}
