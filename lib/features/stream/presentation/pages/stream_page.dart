import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/profile_page/presentation/bloc/profile_page_bloc.dart';
import 'package:tanysu/features/stream/presentation/bloc/stream_bloc.dart';
import 'package:tanysu/features/stream/presentation/pages/live_page.dart';
import 'package:tanysu/l10n/translate.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  late StreamBloc _streamBloc;
  late ProfilePageBloc _profilePageBloc;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    _streamBloc = BlocProvider.of<StreamBloc>(context);
    _profilePageBloc = BlocProvider.of<ProfilePageBloc>(context);
    _profilePageBloc.add(GetMyData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      listener: (context, state) {
        if (kDebugMode) {
          print(state);
        }
        if (state is ProfileGot) {
          _streamBloc.add(GetAllStream());
        }
      },
      builder: (context, state) {
        if (state is ProfileGot) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'tanysu ',
                    style: GoogleFonts.montserratAlternates(
                      color: mainColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'LIVE',
                    style: GoogleFonts.montserratAlternates(
                      color: accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              actions: [
                GestureDetector(
                  child: SvgPicture.asset('assets/icons/start_stream.svg'),
                  onTap: () {
                    jumpToLivePage(
                      context,
                      profileId: state.model.id ?? 0,
                      name: state.model.first_name ?? 'Test_user',
                      isHost: true,
                    );
                  },
                ),
                const SizedBox(width: 20)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocConsumer<StreamBloc, StreamState>(
                listener: (context, state1) {
                  if (kDebugMode) {
                    print(state1);
                  }
                  if (state1 is StreamListGot || state1 is StreamListGetError) {
                    _refreshController.refreshCompleted();
                  }
                },
                builder: (context, state1) {
                  if (state1 is StreamListGot) {
                    return SmartRefresher(
                      header: ClassicHeader(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                          letterSpacing: -0.41,
                        ),
                        idleText: translation(context).pull_to_refresh,
                        releaseText: translation(context).release_to_refresh,
                        refreshingText: translation(context).refreshing_text,
                      ),
                      enablePullDown: true,
                      enablePullUp: false,
                      controller: _refreshController,
                      onRefresh: () async {
                        _streamBloc.add(GetAllStream());
                      },
                      child: GridView.builder(
                        itemCount: state1.streamList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 240,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            jumpToLivePage(
                              context,
                              profileId: state.model.id ?? 0,
                              name: state.model.first_name ?? 'Test_user',
                              isHost: false,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            margin: index == 1 || index == 0
                                ? const EdgeInsets.only(
                                    top: 16,
                                  )
                                : null,
                            // color: Colors.black,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                  state1.streamList[index].profile?['image']
                                          ['image_url'] ??
                                      '',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/stream/eye_24.svg',
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      state1.streamList[index].spectators
                                          .toString(),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              state1.streamList[index]
                                                          .profile?['image']
                                                      ['image_url'] ??
                                                  '',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${state1.streamList[index].profile?['first_name']}, ',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: state1
                                                            .streamList[index]
                                                            .profile?['age']
                                                            .toString() ??
                                                        '',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                state1.streamList[index]
                                                        .description ??
                                                    'Без описание sggdfg df',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  letterSpacing: -0.41,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is StreamListGetting) {
                    return Center(
                      child: Platform.isAndroid
                          ? CircularProgressIndicator(
                              color: secondColor,
                              strokeWidth: 3,
                            )
                          : CupertinoActivityIndicator(
                              color: secondColor,
                            ),
                    );
                  } else {
                    return SmartRefresher(
                      header: ClassicHeader(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                          letterSpacing: -0.41,
                        ),
                        idleText: translation(context).pull_to_refresh,
                        releaseText: translation(context).release_to_refresh,
                        refreshingText: translation(context).refreshing_text,
                      ),
                      enablePullDown: true,
                      enablePullUp: false,
                      controller: _refreshController,
                      onRefresh: () async {
                        _streamBloc.add(GetAllStream());
                      },
                      child: Center(
                        child: Text(translation(context).empty),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(translation(context).empty),
            ),
          );
        }
      },
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
          liveID: 'testLive123321',
          name: name,
          profileId: profileId,
          isHost: isHost,
        ),
      ),
    );
  }
}
