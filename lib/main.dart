import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:tanysu/api/firebase_api.dart';
import 'package:tanysu/core/connection/dependency_injection.dart';
import 'package:tanysu/core/constants/language_constants.dart';
import 'package:tanysu/core/widgets/privacy.dart';
import 'package:tanysu/core/widgets/terms.dart';
import 'package:tanysu/features/add_image/data/repositories/add_image_repo.dart';
import 'package:tanysu/features/add_image/presentation/bloc/add_image_bloc.dart';
import 'package:tanysu/features/block_user/data/repositories/block_repostitory.dart';
import 'package:tanysu/features/block_user/presentation/bloc/block_user_bloc.dart';
import 'package:tanysu/features/chat_page/data/repositories/chat_repository.dart';
import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:tanysu/features/choose_city/data/repositories/choose_city_repository.dart';
import 'package:tanysu/features/choose_city/presentation/bloc/choose_city_bloc.dart';
import 'package:tanysu/features/welcome/presentation/pages/choose_lange_page.dart';
import 'package:tanysu/features/edit_profile/data/repositories/edit_profile_repository.dart';
import 'package:tanysu/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:tanysu/features/get_user_id/data/repositories/get_user_id_repo.dart';
import 'package:tanysu/features/get_user_id/presentation/bloc/get_user_id_bloc.dart';
import 'package:tanysu/features/juz/data/repositories/juz_repository.dart';
import 'package:tanysu/features/juz/presentation/bloc/juz_bloc.dart';
import 'package:tanysu/features/like_page/data/repositories/like_repository.dart';
import 'package:tanysu/features/like_page/presentation/bloc/like_page_bloc.dart';
import 'package:tanysu/features/live/data/repositories/live_repository.dart';
import 'package:tanysu/features/live/presentation/bloc/live_bloc.dart';
import 'package:tanysu/features/login/data/repositories/login_repository.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';
import 'package:tanysu/features/login/presentation/pages/login_by_email.dart';
import 'package:tanysu/features/main_page/data/repositories/user_get_repository.dart';
import 'package:tanysu/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:tanysu/features/main_page/presentation/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:tanysu/features/main_screen.dart';
import 'package:tanysu/features/message/data/repositories/message_repository.dart';
import 'package:tanysu/features/message/presentation/bloc/message_bloc.dart';
import 'package:tanysu/features/notification/presentation/pages/notification_page.dart';
import 'package:tanysu/features/profile_add_info/data/repositories/profile_add_info_repository.dart';
import 'package:tanysu/features/profile_add_info/presentation/bloc/profile_add_info_bloc.dart';
import 'package:tanysu/features/profile_page/data/repositories/profile_page_repository.dart';
import 'package:tanysu/features/profile_page/presentation/bloc/profile_page_bloc.dart';
import 'package:tanysu/features/profile_preview/data/repositories/profile_preview_repository.dart';
import 'package:tanysu/features/profile_preview/presentation/bloc/profile_preview_bloc.dart';
import 'package:tanysu/features/registration/data/repositories/check_email_repository.dart';
import 'package:tanysu/features/registration/data/repositories/registration_repository.dart';
import 'package:tanysu/features/registration/presentation/bloc/check_email_bloc/check_email_bloc.dart';
import 'package:tanysu/features/registration/presentation/pages/choose_page.dart';
import 'package:tanysu/features/report/data/repositories/report_repository.dart';
import 'package:tanysu/features/report/presentation/bloc/report_bloc.dart';
import 'package:tanysu/features/search/data/repositories/search_repo.dart';
import 'package:tanysu/features/search/presentation/bloc/search_bloc.dart';
import 'package:tanysu/features/search/presentation/pages/search_page.dart';
import 'package:tanysu/features/settings/data/repositories/user_logout_repository.dart';
import 'package:tanysu/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tanysu/features/settings/presentation/pages/settings_page.dart';
import 'package:tanysu/features/show_gifts/data/repositories/gift_repo.dart';
import 'package:tanysu/features/show_gifts/presentation/bloc/show_gifts_bloc.dart';
import 'package:tanysu/features/stream/data/repository/stream_repository.dart';
import 'package:tanysu/features/stream/presentation/bloc/stream_bloc.dart';
import 'package:tanysu/firebase_options.dart';
import 'package:tanysu/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/registration/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.debug,
  //   appleProvider: AppleProvider.appAttest,
  // );
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notificationg channel for basic tests',
    )
  ]);
  DependencyInjection.init();
  // await Future.delayed(const Duration(seconds: 1));
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.setLocale(newLocale);
  }
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((value) => setLocale(value));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    });
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegistrationBloc(
              repo: RegistrationRepository(),
              registrationState: const RegistrationState(),
            ),
          ),
          BlocProvider(
            create: (context) => CheckEmailBloc(
              checkEmailState: const CheckEmailState(),
              repo: CheckNumberRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => LoginBloc(
              loginState: const LoginState(),
              repo: LoginRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ChooseCityBloc(
              chooseCityState: const ChooseCityState(),
              repo: ChooseCityRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileAddInfoBloc(
              profileAddInfoState: const ProfileAddInfoState(),
              repo: AddProfileInfoRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => MainPageBloc(
              mainPageState: const MainPageState(),
              repo: UserGetRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfilePreviewBloc(
              previewState: const ProfilePreviewState(),
              repo: ProfilePreviewRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfilePageBloc(
              profilePageState: const ProfilePageState(),
              repo: ProfileRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(
              settingsState: const SettingsState(),
              repo: UserLogOutRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => EditProfileBloc(
              editProfileState: const EditProfileState(),
              repo: EditProfileRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => LikePageBloc(
              likePageState: const LikePageState(),
              repo: LikeRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ChatPageBloc(
              chatPageState: const ChatPageState(),
              repo: ChatRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => GetUserIdBloc(
              getUserIdState: const GetUserIdState(),
              repo: GetUserIdRepo(),
            ),
          ),
          BlocProvider(
            create: (context) => BlockUserBloc(
              blockUserState: const BlockUserState(),
              repo: BlockRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => MessageBloc(
              messageState: const MessageState(),
              repo: MessageRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              searchState: const SearchState(),
              repo: SearchRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => SwipeBloc(
              swipeState: const SwipeState(),
            ),
          ),
          BlocProvider(
            create: (context) => ReportBloc(
              repo: ReportRepository(),
              reportState: const ReportState(),
            ),
          ),
          BlocProvider(
            create: (context) => AddImageBloc(
              repo: AddImageRepository(),
              addImageState: const AddImageState(),
            ),
          ),
          BlocProvider(
            create: (context) => ShowGiftsBloc(
              repo: GetGiftRepository(),
              showGiftsState: const ShowGiftsState(),
            ),
          ),
          BlocProvider(
            create: (context) => JuzBloc(
              repo: JuzRepository(),
              juzState: const JuzState(),
            ),
          ),
          BlocProvider(
            create: (context) => StreamBloc(
              repo: StreamRepository(),
              streamState: const StreamState(),
            ),
          ),
          BlocProvider(
            create: (context) => LiveBloc(
              repo: LiveRepository(),
              liveState: const LiveState(),
            ),
          ),
        ],

        // For building models: flutter pub run build_runner build --delete-conflicting-outputs
        // For changing app icon: flutter pub run flutter_launcher_icons:main
        // For apk: flutter build apk --split-per-abi

        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: L10n.all,
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routes: {
            '/': (context) => const ChooseLanguagePage(),
            '/login/phone': (context) => const LoginByEmail(),
            '/main': (context) => const MainScreen(),
            '/privacy': (context) => const PrivacyPage(),
            '/terms': (context) => const TermsPage(),
            '/choose': (context) => const ChoosePage(),
            '/search': (context) => const SearchPage(),
            '/settings': (context) => const SettingsPage(),
            '/notification': (context) => const NotificationPage(),
          },
          initialRoute: '/',
        ),
      ),
    );
  }
}
