import 'package:flutter/material.dart';
import 'package:tanysu/features/common/widgets/main_button_filled.dart';
import 'package:tanysu/features/registration/presentation/widgets/otp_field.dart';
import 'package:tanysu/features/registration/presentation/widgets/otp_main_text.dart';
import 'package:tanysu/features/registration/presentation/widgets/otp_second_text.dart';
import 'package:tanysu/features/registration/presentation/widgets/resend_button.dart';
import 'package:tanysu/l10n/translate.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  late TextEditingController otpController;
  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String phoneNumber = arguments?['phone_number'];
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
              const OTPMainText(),
              const SizedBox(height: 20),
              Row(
                children: [
                  OTPSecondText(phoneNumber: phoneNumber),
                  const SizedBox(width: 12),
                  const ResendCodeButton(),
                ],
              ),
              const SizedBox(height: 40),
              OTPField(otpController: otpController),
              const Spacer(),
              MainButtonFilled(
                text: translation(context).next,
                onPressed: () {
                  // print(otpController.text);
                  if (otpController.text == '111111') {
                    Navigator.pushNamed(context, '/password/create');
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
    otpController.dispose();
    super.dispose();
  }
}
