// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:tanysu/features/main_page/presentation/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:tanysu/features/main_page/presentation/widgets/main_page_app_bar.dart';
import 'package:tanysu/features/main_page/presentation/widgets/play_button.dart';
import 'package:tanysu/features/main_page/presentation/widgets/tanysu_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page.dart';
import 'package:tanysu/features/show_gifts/presentation/pages/show_gifts.dart';
import 'package:tanysu/l10n/translate.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late AppinioSwiperController cardController;
  late MainPageBloc bloc;
  late SwipeBloc bloc1;
  List<ProfileModel>? users;
  @override
  void initState() {
    cardController = AppinioSwiperController();
    bloc = BlocProvider.of<MainPageBloc>(context);
    bloc1 = BlocProvider.of<SwipeBloc>(context);
    bloc.add(GetUsers());
    // Future.delayed(Duration.zero, () {
    //   AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: 10,
    //       channelKey: 'basic_channel',
    //       title: translation(context).welcome,
    //       body: translation(context).welcome_text,
    //     ),
    //   );
    // });

    super.initState();
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MainPageAppBar(),
            Expanded(
              child: BlocConsumer<MainPageBloc, MainPageState>(
                listener: (context, state) {
                  if (state is UserGot) {
                    users = [];
                    users!.addAll(state.users);
                  } else if (state is UserGetError) {
                    setState(() {
                      users = [];
                    });
                  }
                },
                builder: (context, state) {
                  return users == null
                      ? const SizedBox()
                      : users!.isEmpty
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: Column(
                                  children: [
                                    const Spacer(),
                                    Expanded(
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: PlayButton(
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      translation(context).list_end,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: mainColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Stack(
                                children: [
                                  AppinioSwiper(
                                    cardsSpacing: 25,
                                    threshold: 100,
                                    controller: cardController,
                                    padding: const EdgeInsets.all(0),
                                    backgroundCardsCount: 4,
                                    unswipe: (unswiped) {
                                      if (unswiped) {
                                        counter--;
                                      }
                                    },
                                    onSwiping:
                                        (AppinioSwiperDirection direction) {
                                      if (direction ==
                                          AppinioSwiperDirection.right) {
                                        bloc1.add(GoRight());
                                      }

                                      if (direction ==
                                          AppinioSwiperDirection.left) {
                                        bloc1.add(GoLeft());
                                      }

                                      if (direction ==
                                          AppinioSwiperDirection.top) {
                                        bloc1.add(GoTop());
                                      }

                                      if (direction ==
                                          AppinioSwiperDirection.bottom) {
                                        bloc1.add(GoBottom());
                                      }
                                    },
                                    onSwipeCancelled: () {
                                      bloc1.add(GoBottom());
                                    },
                                    onEnd: () {
                                      // setState(() {
                                      //   users = [];
                                      // });
                                      bloc1.add(GoBottom());
                                      // bloc.add(GetUsers());
                                    },
                                    onSwipe: (index, direction) async {
                                      counter++;
                                      if (counter % 12 == 0) {
                                        bloc.add(GetUsers());
                                      }
                                      bloc1.add(GoBottom());
                                      if (kDebugMode) {
                                        print(direction);
                                      }
                                      if (direction ==
                                          AppinioSwiperDirection.right) {
                                        bloc.add(Like(
                                            profileId:
                                                users![index - 1].id ?? 0));
                                      } else if (direction ==
                                          AppinioSwiperDirection.left) {
                                        bloc.add(DisLike(
                                            profileId:
                                                users![index - 1].id ?? 0));
                                      } else if (direction ==
                                          AppinioSwiperDirection.top) {
                                        await Future.delayed(
                                            const Duration(milliseconds: 100));
                                        cardController.unswipe();
                                        await Future.delayed(
                                            const Duration(milliseconds: 200));
                                        showGifts(
                                          context,
                                          users![index - 1].first_name ?? '',
                                          users![index - 1].id ?? 0,
                                        );
                                      } else if (direction ==
                                          AppinioSwiperDirection.bottom) {
                                        await Future.delayed(
                                            const Duration(milliseconds: 50));
                                        cardController.unswipe();
                                      }
                                    },
                                    cardsBuilder: (context, index) {
                                      return TanysuCard(
                                        user: users![index],
                                        controller: cardController,
                                      );
                                    },
                                    cardsCount: users!.length,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 20,
                                      ),
                                      child: users!.isNotEmpty
                                          ? ButtonsList()
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ButtonsList() {
    return BlocBuilder<SwipeBloc, SwipeState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              cardController.unswipe();
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
              cardController.swipeLeft();
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
                users![counter].first_name ?? '',
                users![counter].id ?? 0,
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
              cardController.swipeRight();
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
                    profile: users![counter],
                    controller: cardController,
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
