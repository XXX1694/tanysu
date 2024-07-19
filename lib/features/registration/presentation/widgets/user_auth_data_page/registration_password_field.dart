import 'package:flutter/material.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class RegistrationPasswordField extends StatefulWidget {
  const RegistrationPasswordField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<RegistrationPasswordField> createState() =>
      _RegistrationPasswordFieldState();
}

class _RegistrationPasswordFieldState extends State<RegistrationPasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        obscuringCharacter: '*',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          suffixIcon: GestureDetector(
            onTap: () => setState(() {
              _obscureText = !_obscureText;
            }),
            child: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black54,
              size: 24,
            ),
          ),
          hintText: translation(context).password,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: mainColor,
            ),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }
}
