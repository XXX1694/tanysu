import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:tanysu/features/main_page/presentation/bloc/swipe_bloc/swipe_bloc.dart';
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
    super.initState();
  }

  @override
  void dispose() {
    cardController.dispose();
    super.dispose();
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const GradientText(
          'Tanysu',
          gradient: LinearGradient(
            colors: <Color>[
              mainColor,
              secondColor,
            ],
          ),
        ),
        actions: [
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              height: 24,
              width: 24,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<MainPageBloc, MainPageState>(
          listener: (context, state) {
            if (kDebugMode) {
              print(state);
            }
            if (state is UserGot) {
              users += state.users;
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
                          const GradientText2(
                            'Tanysu',
                            gradient: LinearGradient(
                              colors: <Color>[
                                mainColor,
                                secondColor,
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  mainColor,
                                  secondColor,
                                ],
                              ),
                            ),
                            height: 38,
                            width: 88,
                            child: Center(
                              child: Text(
                                'LIVE',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            translation(context).list_end,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Stack(
                      children: [
                        AppinioSwiper(
                          threshold: 100,
                          controller: cardController,
                          backgroundCardCount: 15,
                          maxAngle: 30,
                          backgroundCardScale: 0.85,
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
                            child: users.isNotEmpty ? ButtonsList() : null,
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  void _swipeEnd(
      int previousIndex, int targetIndex, SwiperActivity activity) async {
    bloc1.add(GoBottom());
    // counter = previousIndex;
    if (targetIndex % 12 == 0) {
      bloc.add(GetUsers());
    }
    switch (activity) {
      case Swipe():
        if (activity.direction == AxisDirection.left) {
          counter++;
          bloc.add(DisLike(profileId: users[previousIndex].id ?? 0));
        } else if (activity.direction == AxisDirection.right) {
          counter++;
          bloc.add(Like(profileId: users[previousIndex].id ?? 0));
        } else if (activity.direction == AxisDirection.up) {
          counter++;
          await Future.delayed(const Duration(milliseconds: 100));
          cardController.unswipe();
          await Future.delayed(const Duration(milliseconds: 200));
          // ignore: use_build_context_synchronously
          showGifts(
            // ignore: use_build_context_synchronously
            context,
            users[previousIndex].first_name ?? '',
            users[previousIndex].id ?? 0,
          );
        } else if (activity.direction == AxisDirection.down) {
          await Future.delayed(const Duration(milliseconds: 50));
          cardController.unswipe();
        } else {}

        break;
      case Unswipe():
        counter--;
        break;
      case CancelSwipe():
        break;
      case DrivenActivity():
        break;
    }
  }

  void _onEnd() {
    users = [];
    bloc.add(GetUsers());
  }

  // ignore: non_constant_identifier_names
  Widget ButtonsList() {
    return BlocConsumer<SwipeBloc, SwipeState>(
      listener: (context, state) {},
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
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      yellowColor,
                      accentColor
                    ], // Gradient for the inner icon
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
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
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                cardController.swipeLeft();
              },
              child: state is Left
                  ? Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.red,
                            secondColor
                          ], // Gradient for the inner icon
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/cancel.svg',
                          height: 35,
                          width: 35,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                  : ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [
                            Colors.red,
                            secondColor
                          ], // Gradient for the inner icon
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: state is Left ? redColor : Colors.transparent,
                          border: Border.all(
                            width: 2.0,
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
              child: state is Top
                  ? Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            blueColor,
                            accentColor,
                          ], // Gradient for the inner icon
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/star.svg',
                          height: 40,
                          width: 40,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                  : ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [
                            blueColor,
                            accentColor,
                          ], // Gradient for the inner icon
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/star.svg',
                            height: 40,
                            width: 40,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                cardController.swipeRight();
              },
              child: state is Right
                  ? Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(
                          colors: [
                            greenColor,
                            Colors.green,
                          ], // Gradient for the inner icon
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/like.svg',
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                  : ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [
                            greenColor,
                            Colors.green,
                          ], // Gradient for the inner icon
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2.0, color: Colors.white),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/like.svg',
                            width: 30,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
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
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      mainColor,
                      purpleColor
                    ], // Gradient for the inner icon
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
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
              ),
            )
          ],
        );
      },
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserratAlternates(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class GradientText2 extends StatelessWidget {
  final String text;
  final Gradient gradient;

  const GradientText2(
    this.text, {
    super.key,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserratAlternates(
          color: Colors.white,
          fontSize: 64,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
