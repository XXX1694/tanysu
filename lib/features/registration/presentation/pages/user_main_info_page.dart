import 'package:flutter/material.dart';
import 'package:tanysu/core/functions/show_snack_bar.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/features/registration/presentation/pages/user_partner_choose_page.dart';
import 'package:tanysu/l10n/translate.dart';
import '../widgets/create_profile_page/create_profile_main_text.dart';
import '../widgets/create_profile_page/user_data_block.dart';

class UserMainInfoPage extends StatefulWidget {
  const UserMainInfoPage({
    super.key,
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
  @override
  State<UserMainInfoPage> createState() => _UserMainInfoPageState();
}

class _UserMainInfoPageState extends State<UserMainInfoPage> {
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          translation(context).registration,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: CreateProfileMainText(),
              ),
              const SizedBox(height: 32),
              UserDataBlock(
                birthDateController: birthDateContoller,
                cityController: cityController,
                genderController: genderController,
                nameController: nameController,
              ),
              const Spacer(),
              MainButton(
                text: translation(context).next,
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    showSnackBar(context,
                        text: translation(context).name_empty);
                  } else if (birthDateContoller.text.isEmpty) {
                    showSnackBar(context,
                        text: translation(context).birth_date_empty);
                  } else if (cityController.text.isEmpty) {
                    showSnackBar(context,
                        text: translation(context).city_empty);
                  } else if (genderController.text.isEmpty) {
                    showSnackBar(context,
                        text: translation(context).gender_required);
                  } else if (nameController.text.length > 25) {
                    showSnackBar(context,
                        text: translation(context)
                            .name_can_not_be_more_than_25_symbols);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPartnerChoosePage(
                          birthday: birthDateContoller.text,
                          city: cityController.text,
                          email: widget.email,
                          gender: genderController.text,
                          name: nameController.text,
                          password: widget.password,
                        ),
                      ),
                    );
                  }
                },
                status: 'active',
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
