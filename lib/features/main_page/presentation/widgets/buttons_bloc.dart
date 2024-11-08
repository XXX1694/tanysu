import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/main_page/presentation/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page.dart';
import 'package:tanysu/features/show_gifts/presentation/pages/show_gifts.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({
    super.key,
    required this.profile,
    required this.controller,
  });
  final ProfileModel profile;
  final AppinioSwiperController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              controller.unswipe();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: yellowColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/back.svg',
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              controller.swipeLeft();
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: state is Left ? redColor : Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: redColor,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/cancel.svg',
                  height: 35,
                  width: 35,
                  colorFilter: ColorFilter.mode(
                      state is Left ? Colors.white : redColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              showGifts(
                context,
                profile.first_name ?? '',
                profile.id ?? 0,
              );
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: state is Top ? blueColor : Colors.transparent,
                border: Border.all(width: 1, color: blueColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset(
                  state is Top
                      ? 'assets/icons/gift_selected.svg'
                      : 'assets/icons/gift.svg',
                  height: 35,
                  width: 35,
                ),
              ),
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              controller.swipeRight();
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: state is Right ? greenColor : Colors.transparent,
                border: Border.all(width: 1, color: greenColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/like.svg',
                  width: 30,
                  colorFilter: ColorFilter.mode(
                      state is Right ? secondColor : greenColor,
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePreviewPage(
                    profile: profile,
                    controller: controller,
                  ),
                ),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: purpleColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
