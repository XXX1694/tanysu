import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/registration/presentation/bloc/check_email_bloc/check_email_bloc.dart';
import 'package:tanysu/features/registration/presentation/pages/user_main_info_page.dart';
import 'package:tanysu/features/registration/presentation/widgets/user_auth_data_page/registration_email_field.dart';
import 'package:tanysu/features/registration/presentation/widgets/user_auth_data_page/registration_password_field.dart';
import 'package:tanysu/l10n/translate.dart';
import '../../../../common/widgets/main_button_filled.dart';
import '../widgets/get_number_main_text.dart';

class UserAuthDataPage extends StatefulWidget {
  const UserAuthDataPage({super.key});

  @override
  State<UserAuthDataPage> createState() => _UserAuthDataPageState();
}

class _UserAuthDataPageState extends State<UserAuthDataPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late CheckEmailBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<CheckEmailBloc>(context);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              RegistrationEmailField(controller: emailController),
              const SizedBox(height: 20),
              RegistrationPasswordField(controller: passwordController),
              const Spacer(),
              BlocConsumer<CheckEmailBloc, CheckEmailState>(
                builder: (context, state) {
                  if (state is EmailChecking) {
                    return const MainButtonFilledLoading();
                  } else {
                    return MainButtonFilled(
                      text: translation(context).next,
                      onPressed: () {
                        if (emailController.text.isEmpty) {
                          Get.rawSnackbar(
                            messageText: Text(
                              translation(context).email_empty,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            isDismissible: true,
                            duration: const Duration(seconds: 3),
                            margin: const EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                            borderRadius: 10,
                          );
                        } else if (passwordController.text.isEmpty) {
                          Get.rawSnackbar(
                            messageText: Text(
                              translation(context).password_empty,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            isDismissible: true,
                            duration: const Duration(seconds: 3),
                            margin: const EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                            borderRadius: 10,
                          );
                        } else {
                          bloc.add(CheckEmail(email: emailController.text));
                        }
                      },
                    );
                  }
                },
                listener: (context, state) {
                  if (state is EmailChecked) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserMainInfoPage(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        ));
                  } else if (state is EmailCheckError) {
                    Get.rawSnackbar(
                      messageText: Text(
                        state.error,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      isDismissible: true,
                      duration: const Duration(seconds: 3),
                      margin: const EdgeInsets.all(20),
                      backgroundColor: Colors.white,
                      borderRadius: 10,
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
