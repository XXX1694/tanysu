import 'package:flutter/material.dart';
import 'package:tanysu/features/common/widgets/main_button_filled.dart';
import 'package:tanysu/features/create_profile/presentation/widgets/create_profile_main_text.dart';
import 'package:tanysu/l10n/translate.dart';

import '../widgets/user_data_block.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  late TextEditingController nameController;
  late TextEditingController birthDateContoller;
  late TextEditingController genderController;
  late TextEditingController cityController;
  @override
  void initState() {
    nameController = TextEditingController();
    birthDateContoller = TextEditingController();
    genderController = TextEditingController();
    cityController = TextEditingController();
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
              const CreateProfileMainText(),
              const SizedBox(height: 32),
              UserDataBlock(
                birthDateController: birthDateContoller,
                cityController: cityController,
                genderController: genderController,
                nameController: nameController,
              ),
              const Spacer(),
              MainButtonFilled(
                text: translation(context).next,
                onPressed: () {},
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
    nameController.dispose();
    cityController.dispose();
    birthDateContoller.dispose();
    genderController.dispose();
    super.dispose();
  }
}
