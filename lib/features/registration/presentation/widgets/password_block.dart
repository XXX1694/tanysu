import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../l10n/translate.dart';
import '../../../common/widgets/colors.dart';

class PasswordBlock extends StatefulWidget {
  const PasswordBlock({
    super.key,
    required this.passwordController1,
    required this.passwordController2,
  });
  final TextEditingController passwordController1;
  final TextEditingController passwordController2;

  @override
  State<PasswordBlock> createState() => _PasswordBlockState();
}

class _PasswordBlockState extends State<PasswordBlock> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.passwordController2,
          obscureText: _obscureText,
          obscuringCharacter: '*',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () => setState(() {
                _obscureText = !_obscureText;
              }),
              child: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.black54,
              ),
            ),
            hintText: translation(context).password,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: secondColor,
              ),
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: widget.passwordController1,
          obscureText: _obscureText,
          obscuringCharacter: '*',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () => setState(() {
                _obscureText = !_obscureText;
              }),
              child: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.black54,
              ),
            ),
            hintText: translation(context).repeat_password,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: secondColor,
              ),
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
    );
  }
}
