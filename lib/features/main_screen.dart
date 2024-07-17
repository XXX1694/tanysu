import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/functions/generate_string.dart';
import 'package:tanysu/features/chat_page/presentation/pages/chat_page.dart';
import 'package:tanysu/features/main_page/presentation/pages/main_page_new.dart';
import 'package:tanysu/features/profile_page/presentation/bloc/profile_page_bloc.dart';

import 'package:tanysu/features/profile_page/presentation/pages/profile_page.dart';
import 'package:tanysu/features/stream/presentation/pages/live_page.dart';
import 'package:tanysu/features/stream/presentation/pages/stream_page.dart';
import 'package:tanysu/l10n/translate.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ProfilePageBloc _profilePageBloc;
  int profileId = 0;
  String userName = '';
  @override
  void initState() {
    _profilePageBloc = BlocProvider.of<ProfilePageBloc>(context);
    _profilePageBloc.add(GetMyData());
    super.initState();
  }

  Widget _buildNavItem({
    required Widget icon,
    required Widget activeIcon,
    required String label,
    required int index,
    required ref,
    required bool active,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(bottomNavIndexProvider.notifier).update((state) => index);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            active ? activeIcon : icon,
            const SizedBox(height: 2),
            Text(
              label,
              style: active
                  ? Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: mainColor,
                      )
                  : Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.black54,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return IndexedStack(
            index: currentIndex,
            children: const [
              StreamPage(),
              MainPage(),
              ChatPage(),
              ProfilePage(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<ProfilePageBloc, ProfilePageState>(
        listener: (context, state) {
          if (kDebugMode) {
            print(state);
          }
          if (state is ProfileGot) {
            profileId = state.model.id ?? 0;
            userName = state.model.first_name ?? '';
          }
        },
        builder: (context, state) {
          return Consumer(
            builder: (context, ref, child) {
              final currentIndex = ref.watch(bottomNavIndexProvider);
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                // decoration: const BoxDecoration(
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black12,
                //       blurRadius: 10,
                //       spreadRadius: 5,
                //     ),
                //   ],
                // ),
                color: Colors.white,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        icon: SvgPicture.asset(
                          'assets/icons/navigation_icons/main_outlined.svg',
                        ),
                        activeIcon: SvgPicture.asset(
                          'assets/icons/navigation_icons/main_filled.svg',
                          height: 24,
                          width: 24,
                        ),
                        label: translation(context).main,
                        index: 0,
                        ref: ref,
                        active: currentIndex == 0,
                      ),
                      _buildNavItem(
                        activeIcon: SvgPicture.asset(
                          'assets/icons/navigation_icons/swipe_filled.svg',
                          height: 24,
                          width: 24,
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation_icons/swipe_outlined.svg',
                        ),
                        label: translation(context).swipe,
                        index: 1,
                        ref: ref,
                        active: currentIndex == 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              iconPadding: const EdgeInsets.all(8),
                              contentPadding: const EdgeInsets.all(8),
                              insetPadding: const EdgeInsets.all(12),
                              titlePadding: const EdgeInsets.all(16),
                              buttonPadding: const EdgeInsets.all(12),
                              actionsPadding: const EdgeInsets.all(4),
                              title: Text(
                                translation(context).go_live,
                                textAlign: TextAlign.center,
                              ),
                              titleTextStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                              content: Text(
                                translation(context).go_stream,
                                textAlign: TextAlign.center,
                              ),
                              contentTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.black),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    jumpToLivePage(
                                      context,
                                      isHost: true,
                                      profileId: profileId,
                                      name: userName,
                                    );
                                  },
                                  child: Text(
                                    translation(context).yes,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: mainColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    translation(context).no,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/navigation_icons/live.svg',
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                translation(context).stream,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Colors.black54,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildNavItem(
                        activeIcon: SvgPicture.asset(
                          'assets/icons/navigation_icons/chat_filled.svg',
                          height: 24,
                          width: 24,
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation_icons/chat_outlined.svg',
                        ),
                        label: translation(context).chat,
                        index: 2,
                        ref: ref,
                        active: currentIndex == 2,
                      ),
                      _buildNavItem(
                        activeIcon: SvgPicture.asset(
                          'assets/icons/navigation_icons/profile_filled.svg',
                          height: 24,
                          width: 24,
                        ),
                        icon: SvgPicture.asset(
                            'assets/icons/navigation_icons/profile_outlined.svg'),
                        label: translation(context).profile,
                        index: 3,
                        ref: ref,
                        active: currentIndex == 3,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  jumpToLivePage(
    BuildContext context, {
    required bool isHost,
    required int profileId,
    required String name,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          liveID: generateUniqueId(16),
          name: name,
          profileId: profileId,
          isHost: isHost,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tanysu/core/constants/colors.dart';
// import 'package:tanysu/features/chat_page/presentation/pages/chat_page.dart';
// import 'package:tanysu/features/like_page/presentation/pages/like_page.dart';

// import 'package:tanysu/features/profile_page/presentation/pages/profile_page.dart';
// import 'package:tanysu/features/stream/presentation/pages/new_stream_page.dart';
// import 'package:tanysu/features/stream/presentation/pages/stream_page.dart';
// import 'package:tanysu/l10n/translate.dart';

// final bottomNavIndexProvider = StateProvider((ref) => 0);

// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer(
//         builder: (context, ref, child) {
//           final currentIndex = ref.watch(bottomNavIndexProvider);
//           return IndexedStack(
//             index: currentIndex,
//             children: const [
//               StreamPage(),
//               LikePage(),
//               NewStreamPage(),
//               ChatPage(),
//               ProfilePage(),
//             ],
//           );
//         },
//       ),
//       bottomNavigationBar: Consumer(
//         builder: (context, ref, child) {
//           final currentIndex = ref.watch(bottomNavIndexProvider);
//           return BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.white,
//             currentIndex: currentIndex,
//             fixedColor: mainColor,
//             // selectedItemColor: mainColor,
//             useLegacyColorScheme: true,
//             unselectedItemColor: Colors.black54,
//             unselectedLabelStyle: GoogleFonts.montserrat(
//               color: Colors.black54,
//               fontSize: 11,
//               fontWeight: FontWeight.w500,
//               letterSpacing: -0.24,
//             ),
//             enableFeedback: true,
//             selectedLabelStyle: GoogleFonts.montserrat(
//               color: mainColor,
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               letterSpacing: -0.24,
//             ),
//             elevation: 0,
//             showSelectedLabels: true,
//             showUnselectedLabels: true,
//             items: [
//               BottomNavigationBarItem(
//                 activeIcon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/main_filled.svg'),
//                 icon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/main_outlined.svg'),
//                 label: translation(context).main,
//                 backgroundColor: Colors.white,
//               ),
//               BottomNavigationBarItem(
//                 activeIcon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/likes_filled.svg'),
//                 icon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/likes_outlined.svg'),
//                 label: translation(context).likes,
//                 backgroundColor: Colors.white,
//               ),
//               BottomNavigationBarItem(
//                 activeIcon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/start_stream.svg'),
//                 icon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/start_stream.svg'),
//                 // label: translation(context).stream,
//                 label: '',
//                 backgroundColor: Colors.white,
//               ),
//               BottomNavigationBarItem(
//                 activeIcon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/chat_filled.svg'),
//                 icon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/chat_outlined.svg'),
//                 label: translation(context).chat,
//                 backgroundColor: Colors.white,
//               ),
//               BottomNavigationBarItem(
//                 activeIcon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/profile_filled.svg'),
//                 icon: SvgPicture.asset(
//                     'assets/icons/navigation_icons/profile_outlined.svg'),
//                 label: translation(context).profile,
//                 backgroundColor: Colors.white,
//               ),
//             ],
//             onTap: (value) {
//               ref
//                   .read(bottomNavIndexProvider.notifier)
//                   .update((state) => value);
//             },
//           );
//         },
//       ),
//     );
//     // return CupertinoTabScaffold(
//     //   tabBar: CupertinoTabBar(
//     //     border: null,
//     //     activeColor: mainColor,
//     //     backgroundColor: Colors.white,
//     //     items: [
//     //       BottomNavigationBarItem(
//     //         activeIcon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/main_filled.svg'),
//     //         icon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/main_outlined.svg'),
//     //         label: translation(context).main,
//     //       ),
//     //       BottomNavigationBarItem(
//     //         activeIcon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/likes_filled.svg'),
//     //         icon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/likes_outlined.svg'),
//     //         label: translation(context).likes,
//     //       ),
//     //       BottomNavigationBarItem(
//     //         activeIcon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/stream_filled.svg'),
//     //         icon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/stream_outlined.svg'),
//     //         label: translation(context).stream,
//     //       ),
//     //       BottomNavigationBarItem(
//     //         activeIcon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/chat_filled.svg'),
//     //         icon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/chat_outlined.svg'),
//     //         label: translation(context).chat,
//     //       ),
//     //       BottomNavigationBarItem(
//     //         activeIcon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/profile_filled.svg'),
//     //         icon: SvgPicture.asset(
//     //             'assets/icons/navigation_icons/profile_outlined.svg'),
//     //         label: translation(context).profile,
//     //       ),
//     //     ],
//     //   ),
//     //   tabBuilder: (context, index) {
//     //     switch (index) {
//     //       case 0:
//     //         return const MainPage();
//     //       case 1:
//     //         return const LikePage();
//     //       case 2:
//     //         return const StreamPage();
//     //       case 3:
//     //         return const ChatPage();
//     //       case 4:
//     //         return const ProfilePage();
//     //       default:
//     //         return const MainPage();
//     //     }
//     //   },
//     // );
//   }
// }
