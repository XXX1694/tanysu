import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/chat_page/presentation/pages/chat_page.dart';
import 'package:tanysu/features/like_page/presentation/pages/like_page.dart';
import 'package:tanysu/features/main_page/presentation/pages/main_page_new.dart';
import 'package:tanysu/features/profile_page/presentation/pages/profile_page.dart';
import 'package:tanysu/features/stream/presentation/pages/stream_page.dart';
import 'package:tanysu/l10n/translate.dart';

final bottomNavIndexProvider = StateProvider((ref) => 2);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return IndexedStack(
            index: currentIndex,
            children: const [
              MainPage(),
              LikePage(),
              StreamPage(),
              ChatPage(),
              ProfilePage(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            fixedColor: mainColor,
            // selectedItemColor: mainColor,
            useLegacyColorScheme: true,
            unselectedItemColor: Colors.black54,
            unselectedLabelStyle: GoogleFonts.montserrat(
              color: Colors.black54,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.24,
            ),
            enableFeedback: true,
            selectedLabelStyle: GoogleFonts.montserrat(
              color: mainColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.24,
            ),
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                    'assets/icons/navigation_icons/main_filled.svg'),
                icon: SvgPicture.asset(
                    'assets/icons/navigation_icons/main_outlined.svg'),
                label: translation(context).main,
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                    'assets/icons/navigation_icons/likes_filled.svg'),
                icon: SvgPicture.asset(
                    'assets/icons/navigation_icons/likes_outlined.svg'),
                label: translation(context).likes,
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                    'assets/icons/navigation_icons/stream_filled.svg'),
                icon: SvgPicture.asset(
                    'assets/icons/navigation_icons/stream_outlined.svg'),
                label: translation(context).stream,
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                    'assets/icons/navigation_icons/chat_filled.svg'),
                icon: SvgPicture.asset(
                    'assets/icons/navigation_icons/chat_outlined.svg'),
                label: translation(context).chat,
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                    'assets/icons/navigation_icons/profile_filled.svg'),
                icon: SvgPicture.asset(
                    'assets/icons/navigation_icons/profile_outlined.svg'),
                label: translation(context).profile,
                backgroundColor: Colors.white,
              ),
            ],
            onTap: (value) {
              ref
                  .read(bottomNavIndexProvider.notifier)
                  .update((state) => value);
            },
          );
        },
      ),
    );
    // return CupertinoTabScaffold(
    //   tabBar: CupertinoTabBar(
    //     border: null,
    //     activeColor: mainColor,
    //     backgroundColor: Colors.white,
    //     items: [
    //       BottomNavigationBarItem(
    //         activeIcon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/main_filled.svg'),
    //         icon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/main_outlined.svg'),
    //         label: translation(context).main,
    //       ),
    //       BottomNavigationBarItem(
    //         activeIcon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/likes_filled.svg'),
    //         icon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/likes_outlined.svg'),
    //         label: translation(context).likes,
    //       ),
    //       BottomNavigationBarItem(
    //         activeIcon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/stream_filled.svg'),
    //         icon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/stream_outlined.svg'),
    //         label: translation(context).stream,
    //       ),
    //       BottomNavigationBarItem(
    //         activeIcon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/chat_filled.svg'),
    //         icon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/chat_outlined.svg'),
    //         label: translation(context).chat,
    //       ),
    //       BottomNavigationBarItem(
    //         activeIcon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/profile_filled.svg'),
    //         icon: SvgPicture.asset(
    //             'assets/icons/navigation_icons/profile_outlined.svg'),
    //         label: translation(context).profile,
    //       ),
    //     ],
    //   ),
    //   tabBuilder: (context, index) {
    //     switch (index) {
    //       case 0:
    //         return const MainPage();
    //       case 1:
    //         return const LikePage();
    //       case 2:
    //         return const StreamPage();
    //       case 3:
    //         return const ChatPage();
    //       case 4:
    //         return const ProfilePage();
    //       default:
    //         return const MainPage();
    //     }
    //   },
    // );
  }
}
