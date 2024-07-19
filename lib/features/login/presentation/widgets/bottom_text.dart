import 'package:flutter/material.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class LoginBottomText extends StatelessWidget {
  const LoginBottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          translation(context).no_acc,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.black54,
              ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/registration',
            );
          },
          child: Text(
            " ${translation(context).create_acc}",
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
