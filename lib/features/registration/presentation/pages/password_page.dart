import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/common/widgets/main_button_filled.dart';
import 'package:tanysu/features/registration/presentation/widgets/password_block.dart';
import 'package:tanysu/features/registration/presentation/widgets/password_page_main_text.dart';
import 'package:tanysu/features/registration/presentation/widgets/password_page_second_text.dart';
import 'package:tanysu/l10n/translate.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  late TextEditingController passwordController1;
  late TextEditingController passwordController2;
  @override
  void initState() {
    passwordController1 = TextEditingController();
    passwordController2 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const PasswordPageMainText(),
              const SizedBox(height: 20),
              const PasswordPageSecondText(),
              const SizedBox(height: 32),
              PasswordBlock(
                passwordController1: passwordController1,
                passwordController2: passwordController2,
              ),
              const Spacer(),
              MainButtonFilled(
                text: translation(context).create,
                onPressed: () {
                  if (passwordController1.text.isEmpty) {
                    showSnackBar(context, 'Field can not be empty!');
                  } else {
                    if (passwordController1.text == passwordController2.text) {
                      final checkPassword =
                          isStrongPassword(passwordController1.text);
                      if (!checkPassword) {
                        showSnackBar(context,
                            translation(context).password_page_second_text);
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/profile/create', (route) => false);
                      }
                    } else {
                      showSnackBar(context, 'Passwords are not same!');
                    }
                  }
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController1.dispose();
    passwordController2.dispose();
    super.dispose();
  }
}

bool isStrongPassword(String password) {
  // Define your password strength criteria
  const minLength = 8;
  final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  final hasDigits = RegExp(r'\d').hasMatch(password);
  final hasSpecialCharacters =
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  // Check if the password meets all criteria
  return password.length >= minLength &&
      hasUppercase &&
      hasDigits &&
      hasSpecialCharacters;
}

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              offset: Offset(5, 5),
              color: Colors.black26,
              blurRadius: 15,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
