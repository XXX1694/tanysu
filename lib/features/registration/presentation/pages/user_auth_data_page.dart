import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/core/functions/show_snack_bar.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/features/registration/presentation/bloc/check_email_bloc/check_email_bloc.dart';
import 'package:tanysu/features/registration/presentation/pages/user_main_info_page.dart';
import 'package:tanysu/features/registration/presentation/widgets/user_auth_data_page/bottom_text.dart';
import 'package:tanysu/features/registration/presentation/widgets/user_auth_data_page/get_number_second_text.dart';
import 'package:tanysu/features/registration/presentation/widgets/user_auth_data_page/registration_email_field.dart';
import 'package:tanysu/features/registration/presentation/widgets/user_auth_data_page/registration_password_field.dart';
import 'package:tanysu/features/registration/presentation/widgets/user_auth_data_page/third_text.dart';
import 'package:tanysu/l10n/translate.dart';
import '../../../../core/widgets/main_button_filled.dart';
import '../widgets/user_auth_data_page/get_number_main_text.dart';

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
              const GetNumberMainText(),
              const SizedBox(height: 16),
              const GetNumberSecondText(),
              const SizedBox(height: 40),
              RegistrationEmailField(controller: emailController),
              const SizedBox(height: 20),
              RegistrationPasswordField(controller: passwordController),
              const SizedBox(height: 12),
              const ThirdText(),
              const Spacer(),
              BlocConsumer<CheckEmailBloc, CheckEmailState>(
                builder: (context, state) {
                  if (state is EmailChecking) {
                    return const MainButtonFilledLoading();
                  } else {
                    return MainButton(
                      text: translation(context).next,
                      onPressed: () {
                        if (emailController.text.isEmpty) {
                          showSnackBar(context,
                              text: translation(context).email_empty);
                        } else if (passwordController.text.isEmpty) {
                          showSnackBar(
                            context,
                            text: translation(context).password_empty,
                          );
                        } else {
                          bloc.add(
                            CheckEmail(
                              email: emailController.text,
                            ),
                          );
                        }
                      },
                      status: 'active',
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
                    showSnackBar(context, text: state.error);
                  }
                },
              ),
              const SizedBox(height: 12),
              const RegistrationBottomText(),
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
