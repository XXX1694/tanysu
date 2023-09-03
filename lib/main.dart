import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tanysu/features/common/widgets/privacy.dart';
import 'package:tanysu/features/create_profile/presentation/pages/create_profile_page.dart';
import 'package:tanysu/features/login/presentation/pages/login_page.dart';
import 'package:tanysu/features/registration/presentation/pages/get_number_page.dart';
import 'package:tanysu/features/registration/presentation/pages/otp_verification_page.dart';
import 'package:tanysu/features/registration/presentation/pages/password_page.dart';
import 'package:tanysu/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    initialization();
    super.initState();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routes: {
        '/': (context) => const LoginPage(),
        '/privacy': (context) => const PrivacyPage(),
        '/get_number': (context) => const GetNumberPage(),
        '/otp': (context) => const OTPVerificationPage(),
        '/password/create': (context) => const CreatePasswordPage(),
        '/profile/create': (context) => const CreateProfilePage(),
      },
    );
  }
}
