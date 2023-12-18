import 'dart:io';

import 'package:appinio_swiper/controllers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/like_page/presentation/bloc/like_page_bloc.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_main.dart';
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.add(GetLikes());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 14),
            Text(
              'tanysu',
              style: GoogleFonts.montserrat(
                color: secondColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<LikePageBloc, LikePageState>(
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
                                  color: !iLiked ? secondColor : Colors.black45,
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
                                  color: iLiked ? secondColor : Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Center(
                          child: state is LikeGot
                              ? iLiked
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: SmartRefresher(
                                              enablePullDown: true,
                                              enablePullUp: true,
                                              controller: _refreshController,
                                              onRefresh: () async {
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500));
                                                bloc.add(GetLikes());
                                              },
                                              child: GridView.builder(
                                                itemCount: state.meLike.length,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 20,
                                                  crossAxisSpacing: 12,
                                                  childAspectRatio: 15 / 20,
                                                ),
                                                itemBuilder: (context, index) =>
                                                    GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfilePreviewPageMain(
                                                          profileId: state
                                                                  .meLike[index]
                                                                  .id ??
                                                              0,
                                                          controller:
                                                              cardController,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    // height: 210,
                                                    // width: 165,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: state
                                                                  .meLike[index]
                                                                  .image!
                                                                  .containsKey(
                                                                      'image_url')
                                                              ? CachedNetworkImage(
                                                                  imageUrl: state
                                                                      .meLike[
                                                                          index]
                                                                      .image!['image_url'],
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Shimmer
                                                                          .fromColors(
                                                                    baseColor:
                                                                        secondColor,
                                                                    highlightColor:
                                                                        mainColor,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          210,
                                                                      width:
                                                                          165,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Container(
                                                                    height: 210,
                                                                    width: 165,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  imageBuilder:
                                                                      (context,
                                                                          imageProvider) {
                                                                    return Container(
                                                                      height:
                                                                          210,
                                                                      width:
                                                                          165,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : Container(
                                                                  height: 210,
                                                                  width: 165,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 12,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              const Spacer(),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 8,
                                                                    width: 8,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    '${state.meLike[index].first_name ?? ''}, ${state.meLike[index].age ?? 0}',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 12),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: SmartRefresher(
                                              enablePullDown: true,
                                              enablePullUp: true,
                                              controller: _refreshController,
                                              onRefresh: () async {
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500));
                                                bloc.add(GetLikes());
                                              },
                                              child: GridView.builder(
                                                itemCount: state.likesMe.length,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  // crossAxisSpacing: 20,
                                                  mainAxisSpacing: 20,
                                                  mainAxisExtent: 210,
                                                ),
                                                itemBuilder: (context, index) =>
                                                    GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfilePreviewPageMain(
                                                          profileId: state
                                                                  .likesMe[
                                                                      index]
                                                                  .id ??
                                                              0,
                                                          controller:
                                                              cardController,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 210,
                                                    width: 165,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: state
                                                                  .likesMe[
                                                                      index]
                                                                  .image!
                                                                  .containsKey(
                                                                      'image_url')
                                                              ? Image.network(
                                                                  state
                                                                      .likesMe[
                                                                          index]
                                                                      .image!['image_url'],
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 210,
                                                                  width: 165,
                                                                )
                                                              : Container(
                                                                  height: 210,
                                                                  width: 165,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 12,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              const Spacer(),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 8,
                                                                    width: 8,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    '${state.likesMe[index].first_name ?? ''}, ${state.likesMe[index].age ?? 0}',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 12),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                              : Platform.isAndroid
                                  ? CircularProgressIndicator(
                                      color: secondColor,
                                      strokeWidth: 3,
                                    )
                                  : CupertinoActivityIndicator(
                                      color: secondColor,
                                    ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
