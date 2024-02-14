import 'dart:io';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_main.dart';
import 'package:tanysu/features/search/presentation/bloc/search_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc bloc;
  late AppinioSwiperController cardController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;
  @override
  void initState() {
    cardController = AppinioSwiperController();
    bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(
      GetUsers(
        cityId: null,
        gender: null,
        maxAge: null,
        page: page,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          translation(context).search,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        // leading: null,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CupertinoButton(
              padding: const EdgeInsets.all(0),
              child: SvgPicture.asset(
                'assets/icons/sort.svg',
                height: 24,
                width: 24,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/filter');
              },
            ),
          ),
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(78.0),
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        //     child: Container(
        //       height: 50,
        //       decoration: BoxDecoration(
        //         color: const Color(0XFFF3F3F3),
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 20),
        //         child: Center(
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               SvgPicture.asset(
        //                 'assets/icons/search.svg',
        //                 height: 18,
        //                 width: 18,
        //               ),
        //               const SizedBox(width: 10),
        //               Expanded(
        //                 child: Center(
        //                   child: TextField(
        //                     cursorColor: accentColor,
        //                     textAlignVertical: TextAlignVertical.center,
        //                     decoration: const InputDecoration(
        //                       hintText: 'Search',
        //                       contentPadding:
        //                           EdgeInsets.symmetric(vertical: 14),
        //                       border: InputBorder.none,
        //                     ),
        //                     textAlign: TextAlign.left,
        //                     maxLines: 1,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is GotUsers) {
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                    page++;
                    bloc.add(
                      GetUsers(
                        cityId: null,
                        gender: null,
                        maxAge: null,
                        page: page,
                      ),
                    );
                  },
                  onLoading: () {},
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePreviewPageMain(
                              profileId: state.users[index]['id'],
                              controller: cardController,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: index == 0
                            ? const EdgeInsets.fromLTRB(0, 20, 0, 16)
                            : const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        width: double.infinity,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                state.users[index]['image']['image_url'] ?? '',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.users[index]['first_name'] ?? '',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${state.users[index]['age'] ?? ''}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is GettingUsers) {
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
                return Center(
                  child: Text(translation(context).not_found),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
