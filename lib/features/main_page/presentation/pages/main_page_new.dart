import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:tanysu/features/main_page/presentation/bloc/swipe_bloc/swipe_bloc.dart';
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
  List<ProfileModel> users = [];
  @override
  void initState() {
    cardController = AppinioSwiperController();
    bloc = BlocProvider.of<MainPageBloc>(context);
    bloc1 = BlocProvider.of<SwipeBloc>(context);
    bloc.add(GetUsers());
    // Future.delayed(const Duration(seconds: 1)).then((_) {
    //   _shakeCard();
    // });
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
      appBar: AppBar(
        title: Text(
          'tanysu',
          style: GoogleFonts.montserrat(
            color: mainColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          GestureDetector(
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              height: 24,
              width: 24,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          const SizedBox(width: 20),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black12,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<MainPageBloc, MainPageState>(
                listener: (context, state) {
                  if (state is UserGot) {
                    users.addAll(state.users);
                  }
                },
                builder: (context, state) {
                  return users.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
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
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Stack(
                            children: [
                              AppinioSwiper(
                                threshold: 100,
                                controller: cardController,
                                backgroundCardCount: 6,
                                maxAngle: 30,
                                backgroundCardScale: 0.87,
                                swipeOptions: const SwipeOptions.all(),
                                onSwipeEnd: _swipeEnd,
                                onEnd: _onEnd,
                                onCardPositionChanged: (position) {
                                  if (position.offset.dx <= -20) {
                                    bloc1.add(GoLeft());
                                  } else if (position.offset.dx >= 20) {
                                    bloc1.add(GoRight());
                                  } else if (position.offset.dx <= 20 &&
                                      position.offset.dx >= -20 &&
                                      position.offset.dy <= -20) {
                                    bloc1.add(GoTop());
                                  } else {
                                    bloc1.add(GoBottom());
                                  }
                                },
                                cardBuilder: (context, index) {
                                  counter = index - 1;
                                  return TanysuCard(
                                    user: users[index],
                                    controller: cardController,
                                  );
                                },
                                cardCount: users.length,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 20,
                                  ),
                                  child:
                                      users.isNotEmpty ? ButtonsList() : null,
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

  // Future<void> _shakeCard() async {
  //   const double distance = 30;
  //   // We can animate back and forth by chaining different animations.
  //   await cardController.animateTo(
  //     const Offset(-distance, 0),
  //     duration: const Duration(milliseconds: 200),
  //     curve: Curves.easeInOut,
  //   );
  //   await cardController.animateTo(
  //     const Offset(distance, 0),
  //     duration: const Duration(milliseconds: 400),
  //     curve: Curves.easeInOut,
  //   );
  //   // We need to animate back to the center because `animateTo` does not center
  //   // the card for us.
  //   await cardController.animateTo(
  //     const Offset(0, 0),
  //     duration: const Duration(milliseconds: 200),
  //     curve: Curves.easeInOut,
  //   );
  // }

  void _swipeEnd(
      int previousIndex, int targetIndex, SwiperActivity activity) async {
    bloc1.add(GoBottom());
    counter = previousIndex;
    if (targetIndex == users.length - 3) {
      bloc.add(GetUsers());
    }
    switch (activity) {
      case Swipe():
        if (activity.direction == AxisDirection.left) {
          // bloc.add(DisLike(profileId: users[previousIndex].id ?? 0));
        } else if (activity.direction == AxisDirection.right) {
          bloc.add(Like(profileId: users[previousIndex].id ?? 0));
        } else if (activity.direction == AxisDirection.up) {
          await Future.delayed(const Duration(milliseconds: 100));
          cardController.unswipe();
          await Future.delayed(const Duration(milliseconds: 200));
          // ignore: use_build_context_synchronously
          showGifts(
            context,
            users[previousIndex].first_name ?? '',
            users[previousIndex].id ?? 0,
          );
        } else if (activity.direction == AxisDirection.down) {
          await Future.delayed(const Duration(milliseconds: 50));
          cardController.unswipe();
        } else {}
        if (kDebugMode) {
          print('The card was swiped to the : ${activity.direction}');
          print('previous index: $previousIndex, target index: $targetIndex');
        }

        break;
      case Unswipe():
        if (kDebugMode) {
          print('A ${activity.direction.name} swipe was undone.');
          print('previous index: $previousIndex, target index: $targetIndex');
        }

        break;
      case CancelSwipe():
        if (kDebugMode) {
          print('A swipe was cancelled');
        }
        break;
      case DrivenActivity():
        if (kDebugMode) {
          print('Driven Activity');
        }
        break;
    }
  }

  void _onEnd() {
    users = [];
    bloc.add(GetUsers());
    if (kDebugMode) {
      print('end reached!');
    }
  }

  // ignore: non_constant_identifier_names
  Widget ButtonsList() {
    return BlocConsumer<SwipeBloc, SwipeState>(
      listener: (context, state) {
        if (kDebugMode) {
          print(state);
        }
      },
      builder: (context, state) {
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
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: yellowColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/back.svg',
                    height: 22,
                    width: 22,
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
                    width: 2.5,
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
                        state is Left ? Colors.white : redColor,
                        BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                showGifts(
                  context,
                  users[counter].first_name ?? '',
                  users[counter].id ?? 0,
                );
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: state is Top ? blueColor : Colors.transparent,
                  border: Border.all(width: 2, color: blueColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/star.svg',
                    height: 40,
                    width: 40,
                    colorFilter: ColorFilter.mode(
                        state is Top ? Colors.white : blueColor,
                        BlendMode.srcIn),
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
                  border: Border.all(width: 2.5, color: greenColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/like.svg',
                    width: 30,
                    colorFilter: ColorFilter.mode(
                        state is Right ? Colors.white : greenColor,
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
                      profile: users[counter],
                      controller: cardController,
                    ),
                  ),
                );
              },
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: purpleColor),
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
      },
    );
  }
}
