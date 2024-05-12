import 'dart:io';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_main.dart';
import 'package:tanysu/features/search/data/models/search_result_model.dart';
import 'package:tanysu/features/search/presentation/bloc/search_bloc.dart';
import 'package:tanysu/features/search/presentation/pages/filter_page.dart';
import 'package:tanysu/l10n/translate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc bloc;
  late AppinioSwiperController cardController;
  // final RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  int page = 1;
  int? cityId;
  int? maxAge;
  int? minAge;
  String? gender;
  List<SearchResultModel> users = [];
  late ScrollController controller;

  late TextEditingController _cityController;
  late TextEditingController _genderController;
  late TextEditingController _minAgeController;
  late TextEditingController _maxAgeController;

  @override
  void initState() {
    _cityController = TextEditingController();
    _genderController = TextEditingController();
    _minAgeController = TextEditingController();
    _maxAgeController = TextEditingController();
    controller = ScrollController();
    cardController = AppinioSwiperController();
    bloc = BlocProvider.of<SearchBloc>(context);
    page = 1;
    bloc.add(
      GetUsers(
        cityId: null,
        gender: null,
        maxAge: null,
        page: page,
        minAge: null,
      ),
    );
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        page++;
        reload();
      }
    });
    super.initState();
  }

  void reload() {
    bloc.add(
      GetUsers(
        cityId: cityId,
        gender: gender,
        maxAge: maxAge,
        page: page,
        minAge: minAge,
      ),
    );
  }

  void changeFilter({
    required int? cityId,
    required int? maxAge,
    required int? minAge,
    required String? gender,
  }) {
    users = [];
    page = 1;
    this.cityId = cityId;
    this.gender = gender;
    this.maxAge = maxAge;
    this.minAge = minAge;
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          translation(context).search,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        // leading: null,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        centerTitle: true, leadingWidth: 40,
        leading: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              child: SvgPicture.asset(
                'assets/icons/back_button.svg',
                height: 24,
                width: 24,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterPage(
                      callback: changeFilter,
                      cityController: _cityController,
                      genderController: _genderController,
                      maxAgeController: _maxAgeController,
                      minAgeController: _minAgeController,
                    ),
                  ),
                );
              },
            ),
          ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is GotUsers) {
                users.addAll(state.users);
              }
            },
            builder: (context, state) {
              if (users.isNotEmpty) {
                return ListView.builder(
                  itemCount: users.length + 1,
                  controller: controller,
                  itemBuilder: (context, index) {
                    if (index < users.length) {
                      SearchResultModel user = users[index];
                      return CupertinoButton(
                        padding: index == 0
                            ? const EdgeInsets.fromLTRB(0, 16, 0, 16)
                            : const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePreviewPageMain(
                                profileId: user.id,
                                controller: cardController,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  user.image['image_url'],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: user.first_name.toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ', ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: user.age.toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    user.city_name.toString(),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                                color: secondColor,
                                strokeWidth: 3,
                              )
                            : CupertinoActivityIndicator(
                                color: secondColor,
                              ),
                      );
                    }
                  },
                );
              } else {
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
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _cityController.dispose();
    _genderController.dispose();
    _maxAgeController.dispose();
    _minAgeController.dispose();
    page = 1;
    super.dispose();
  }
}


 // footer: ClassicFooter(
                  //   textStyle: const TextStyle(
                  //     color: Colors.grey,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //     decoration: TextDecoration.none,
                  //   ),
                  //   idleText: translation(context).pull_to_refresh,
                  //   // releaseText: translation(context).release_to_refresh,
                  // ),
                  // header: ClassicHeader(
                  //   textStyle: const TextStyle(
                  //     color: Colors.grey,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //     decoration: TextDecoration.none,
                  //   ),
                  //   idleText: translation(context).pull_to_refresh,
                  //   releaseText: translation(context).release_to_refresh,
                  // ),
                  // enablePullDown: true,
                  // enablePullUp: true,
                  // controller: _refreshController,
                  // onRefresh: () {
                  //   page++;
                  //   bloc.add(
                  //     GetUsers(
                  //       cityId: cityId,
                  //       gender: gender,
                  //       maxAge: maxAge,
                  //       page: page,
                  //       minAge: minAge,
                  //     ),
                  //   );
                  // },




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