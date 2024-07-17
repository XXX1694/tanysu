import 'dart:io';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/like_page/presentation/bloc/like_page_bloc.dart';
import 'package:tanysu/features/like_page/presentation/widgets/likes_list.dart';
import 'package:tanysu/l10n/translate.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

bool iLiked = true;

class _LikePageState extends State<LikePage> {
  late LikePageBloc bloc;
  late AppinioSwiperController cardController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    cardController = AppinioSwiperController();
    bloc.add(GetLikes());
    super.initState();
  }

  void reload() {
    bloc.add(GetLikes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'tanysu',
          style: GoogleFonts.montserratAlternates(
            color: mainColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<LikePageBloc, LikePageState>(
          listener: (context, state) {
            if (state is LikeGot || state is LikeGetError) {
              _refreshController.refreshCompleted();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            iLiked = false;
                          });
                        },
                        child: Text(
                          translation(context).liled_me,
                          style: GoogleFonts.montserrat(
                            color: !iLiked ? mainColor : Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 26,
                      width: 1,
                      color: Colors.black26,
                    ),
                    Expanded(
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            iLiked = true;
                          });
                        },
                        child: Text(
                          translation(context).i_liked,
                          style: GoogleFonts.montserrat(
                            color: iLiked ? mainColor : Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: state is LikeGot
                        ? iLiked
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: LikesList(
                                        list: state.meLike,
                                        reloadFunc: () {
                                          reload();
                                        },
                                        refreshController: _refreshController,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: LikesList(
                                        list: state.likesMe,
                                        reloadFunc: () {
                                          reload();
                                        },
                                        refreshController: _refreshController,
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : Center(
                            child: Platform.isAndroid
                                ? const CircularProgressIndicator(
                                    color: mainColor,
                                    strokeWidth: 3,
                                  )
                                : const CupertinoActivityIndicator(
                                    color: mainColor,
                                  ),
                          ),
                    // Platform.isAndroid
                    //     ? CircularProgressIndicator(
                    //         color: mainColor,
                    //         strokeWidth: 3,
                    //       )
                    //     : CupertinoActivityIndicator(
                    //         color: mainColor,
                    //       ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
