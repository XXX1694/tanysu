import 'package:flutter/material.dart';
import 'package:tanysu/features/registration/presentation/widgets/phone_number_field.dart';
import 'package:tanysu/l10n/translate.dart';

import '../../../common/widgets/main_button_filled.dart';
import '../widgets/get_number_main_text.dart';
import '../widgets/get_number_second_text.dart';

class GetNumberPage extends StatefulWidget {
  const GetNumberPage({super.key});

  @override
  State<GetNumberPage> createState() => _GetNumberPageState();
}

class _GetNumberPageState extends State<GetNumberPage> {
  late TextEditingController phoneNumberController;
  @override
  void initState() {
    phoneNumberController = TextEditingController();
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
            children: [
              const SizedBox(height: 40),
              const GetNumberMainText(),
              const SizedBox(height: 32),
              PhoneNumberField(controller: phoneNumberController),
              const SizedBox(height: 48),
              const GetNumberSecondText(),
              const Spacer(),
              MainButtonFilled(
                text: translation(context).next,
                onPressed: () {
                  // print(phoneNumberController.text);
                  // print(phoneNumberController.text.length);
                  if (phoneNumberController.text.length == 18) {
                    Navigator.pushNamed(
                      context,
                      '/otp',
                      arguments: {
                        'phone_number': phoneNumberController.text,
                      },
                    );
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
    phoneNumberController.dispose();
    super.dispose();
  }
}
