import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/chat_page/presentation/pages/chat_page.dart';
import 'package:tanysu/features/like_page/presentation/pages/like_page.dart';

import 'package:tanysu/features/profile_page/presentation/pages/profile_page.dart';
import 'package:tanysu/features/stream/presentation/pages/stream_page.dart';
import 'package:tanysu/l10n/translate.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget _buildNavItem({
    required SvgPicture icon,
    required SvgPicture activeIcon,
    required String label,
    required int index,
    required ref,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(bottomNavIndexProvider.notifier).update((state) => index);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: mainColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.24,
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
      body: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return IndexedStack(
            index: currentIndex,
            children: const [
              StreamPage(),
              LikePage(),
              ChatPage(),
              ProfilePage(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          ref.watch(bottomNavIndexProvider);
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: SvgPicture.asset(
                      'assets/icons/navigation_icons/main_outlined.svg'),
                  activeIcon: SvgPicture.asset(
                      'assets/icons/navigation_icons/main_filled.svg'),
                  label: 'Home',
                  index: 0,
                  ref: ref,
                ),
                _buildNavItem(
                  activeIcon: SvgPicture.asset(
                      'assets/icons/navigation_icons/likes_filled.svg'),
                  icon: SvgPicture.asset(
                      'assets/icons/navigation_icons/likes_outlined.svg'),
                  label: translation(context).likes,
                  index: 1,
                  ref: ref,
                ),
                SvgPicture.asset(
                    'assets/icons/navigation_icons/start_stream.svg'),
                _buildNavItem(
                  activeIcon: SvgPicture.asset(
                      'assets/icons/navigation_icons/chat_filled.svg'),
                  icon: SvgPicture.asset(
                      'assets/icons/navigation_icons/chat_outlined.svg'),
                  label: translation(context).chat,
                  index: 2,
                  ref: ref,
                ),
                _buildNavItem(
                  activeIcon: SvgPicture.asset(
                      'assets/icons/navigation_icons/profile_filled.svg'),
                  icon: SvgPicture.asset(
                      'assets/icons/navigation_icons/profile_outlined.svg'),
                  label: translation(context).profile,
                  index: 3,
                  ref: ref,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
