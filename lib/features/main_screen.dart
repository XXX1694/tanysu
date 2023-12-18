import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/features/chat_page/presentation/pages/chat_page.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/like_page/presentation/pages/like_page.dart';
import 'package:tanysu/features/profile_page/presentation/pages/profile_page.dart';
import 'package:tanysu/l10n/translate.dart';

import 'main_page/presentation/pages/main_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: secondColor,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/navigation_icons/main_filled.svg'),
            icon: SvgPicture.asset(
                'assets/icons/navigation_icons/main_outlined.svg'),
            label: translation(context).main,
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/navigation_icons/likes_filled.svg'),
            icon: SvgPicture.asset(
                'assets/icons/navigation_icons/likes_outlined.svg'),
            label: translation(context).likes,
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/navigation_icons/chat_filled.svg'),
            icon: SvgPicture.asset(
                'assets/icons/navigation_icons/chat_outlined.svg'),
            label: translation(context).chat,
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/navigation_icons/profile_filled.svg'),
            icon: SvgPicture.asset(
                'assets/icons/navigation_icons/profile_outlined.svg'),
            label: translation(context).profile,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const MainPage();
          case 1:
            return const LikePage();
          case 2:
            return const ChatPage();
          case 3:
            return const ProfilePage();
          default:
            return const MainPage();
        }
      },
    );
  }
}
