import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/user_verify/presentation/widgets/verification_icon.dart';

class NameBlock extends StatelessWidget {
  const NameBlock({
    super.key,
    required this.name,
    required this.age,
  });
  final String name;
  final int age;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$name, $age',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 12),
        const VerificationIcon(),
      ],
    );
  }
}
