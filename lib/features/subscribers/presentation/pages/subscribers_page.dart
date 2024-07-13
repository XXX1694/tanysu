import 'dart:io';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_main.dart';
import 'package:tanysu/features/subscribers/presentation/bloc/subscribers_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class SubscribersPage extends StatefulWidget {
  const SubscribersPage({super.key});

  @override
  State<SubscribersPage> createState() => _SubscribersPageState();
}

class _SubscribersPageState extends State<SubscribersPage> {
  late SubscribersBloc bloc;
  late AppinioSwiperController cardController;

  @override
  void initState() {
    bloc = BlocProvider.of<SubscribersBloc>(context);
    cardController = AppinioSwiperController();
    reload();
    super.initState();
  }

  void reload() {
    bloc.add(
      GetAllSubscribers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          translation(context).followerss,
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
          child: BlocConsumer<SubscribersBloc, SubscribersState>(
            listener: (context, state) {
              // print(state);
            },
            builder: (context, state) {
              if (state is GotUsers) {
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) => CupertinoButton(
                    padding: index == 0
                        ? const EdgeInsets.fromLTRB(0, 16, 0, 16)
                        : const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePreviewPageMain(
                            profileId: state.users[index].id,
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
                              state.users[index].image['image_url'],
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
                                      text: state.users[index].first_name
                                          .toString(),
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
                                      text: state.users[index].age.toString(),
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
                                state.users[index].city_name.toString(),
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
                  ),
                );
              } else {
                return Center(
                  child: Platform.isAndroid
                      ? const CircularProgressIndicator(
                          color: mainColor,
                          strokeWidth: 3,
                        )
                      : const CupertinoActivityIndicator(
                          color: mainColor,
                        ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
