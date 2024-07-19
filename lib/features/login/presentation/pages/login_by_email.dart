import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/core/functions/show_snack_bar.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/core/widgets/main_button_filled.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';
import 'package:tanysu/features/login/presentation/widgets/login_main_text.dart';
import 'package:tanysu/features/login/presentation/widgets/login_second_text.dart';
import 'package:tanysu/features/login/presentation/widgets/password_field.dart';
import 'package:tanysu/features/login/presentation/widgets/email_field.dart';
import 'package:tanysu/features/main_screen.dart';
import 'package:tanysu/l10n/translate.dart';

import '../widgets/bottom_text.dart';

class LoginByEmail extends StatefulWidget {
  const LoginByEmail({super.key});

  @override
  State<LoginByEmail> createState() => _LoginByEmailState();
}

class _LoginByEmailState extends State<LoginByEmail> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late LoginBloc bloc;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    bloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          translation(context).login_main_text,
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
              const LoginMainText(),
              const SizedBox(height: 16),
              const LoginSecondText(),
              const SizedBox(height: 40),
              EmailField(controller: _emailController),
              const SizedBox(height: 20),
              PasswordField(controller: _passwordController),
              const Spacer(),
              BlocConsumer<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LogingIn) {
                    return const MainButtonFilledLoading();
                  } else {
                    return MainButton(
                      text: translation(context).login,
                      onPressed: () {
                        bloc.add(
                          LogIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                      status: 'active',
                    );
                  }
                },
                listener: (context, state) {
                  if (state is LoginError) {
                    showSnackBar(context, text: 'Login error');
                  } else if (state is LogedIn) {
                    AwesomeNotifications().createNotification(
                      content: NotificationContent(
                        id: 10,
                        channelKey: 'basic_channel',
                        title: translation(context).welcome,
                        body: translation(context).welcome_text,
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
              const SizedBox(height: 12),
              const LoginBottomText(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
