import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/common/providers/home_provider.dart';
import 'package:tanysu/features/message/presentation/pages/message_page.dart';
import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:tanysu/features/get_user_id/presentation/bloc/get_user_id_bloc.dart';
import 'package:tanysu/features/message/presentation/pages/message_page_public.dart';
import 'package:tanysu/l10n/translate.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatPageBloc bloc;
  late GetUserIdBloc bloc1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    bloc = BlocProvider.of<ChatPageBloc>(context);
    bloc1 = BlocProvider.of<GetUserIdBloc>(context);
    bloc1.add(GetuserId());
    bloc.add(GetAllChats());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bloc.add(GetAllChats());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'tanysu',
          style: GoogleFonts.montserrat(
            color: secondColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<GetUserIdBloc, GetUserIdState>(
                  builder: (context, state1) {
                    return BlocConsumer<ChatPageBloc, ChatPageState>(
                      listener: (context, state) {
                        if (state is ChatDeleted || state is ChatDeleteError) {
                          bloc.add(
                            GetAllChats(),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ChatListGot && state1 is GotUserId) {
                          return SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: false,
                            controller: _refreshController,
                            onRefresh: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              bloc1.add(GetuserId());
                              bloc.add(GetAllChats());
                            },
                            child: ListView.builder(
                              itemCount: state.chats.length,
                              itemBuilder: (context, index) => Dismissible(
                                key: ValueKey(state.chats[index]),
                                background: Container(
                                  color: mainColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        translation(context).unmatch,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                                onDismissed: (direction) {
                                  setState(
                                    () {
                                      bloc.add(
                                        DeleteChat(
                                          chatId: state.chats[index].id,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: CupertinoButton(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  onPressed: () {
                                    if (state.chats[index].is_public) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                            create: (context) => HomeProvider(),
                                            child: PublicMessagePage(
                                              name: state.chats[index]
                                                      .is_admin_chat
                                                  ? translation(context).support
                                                  : (state.chats[index].name ??
                                                      ''),
                                              image: state
                                                      .chats[index].is_public
                                                  ? state.chats[index]
                                                          .group_photo ??
                                                      ''
                                                  : state.chats[index]
                                                              .profile?['image']
                                                          ['image_url'] ??
                                                      '',
                                              chatId: state.chats[index].id,
                                              userId: state1.userId,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                            create: (context) => HomeProvider(),
                                            child: MessagePage(
                                              name: state.chats[index]
                                                      .is_admin_chat
                                                  ? translation(context).support
                                                  : (state.chats[index]
                                                              .profile?[
                                                          'first_name'] ??
                                                      ''),
                                              image: state.chats[index]
                                                          .profile?['image']
                                                      ['image_url'] ??
                                                  '',
                                              chatId: state.chats[index].id,
                                              userId: state1.userId,
                                              profileId: state
                                                  .chats[index].profile?['id'],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              state.chats[index].is_public
                                                  ? state.chats[index]
                                                          .group_photo ??
                                                      ''
                                                  : state.chats[index]
                                                              .profile?['image']
                                                          ['image_url'] ??
                                                      ''),
                                          onBackgroundImageError:
                                              (exception, stackTrace) =>
                                                  Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.green,
                                          ),
                                          radius: 25,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    state.chats[index]
                                                            .is_admin_chat
                                                        ? translation(context)
                                                            .support
                                                        : state.chats[index]
                                                                .is_public
                                                            ? state.chats[index]
                                                                .name
                                                            : state.chats[index]
                                                                        .profile?[
                                                                    'first_name'] ??
                                                                '',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    state.chats[index]
                                                                .last_message !=
                                                            null
                                                        ? DateFormat('HH:mm')
                                                            .format(DateTime
                                                                .parse(state
                                                                        .chats[
                                                                            index]
                                                                        .last_message?[
                                                                    'timestamp']))
                                                            .toString()
                                                        : '',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                state.chats[index]
                                                            .last_message ==
                                                        null
                                                    ? state.chats[index]
                                                            .is_admin_chat
                                                        ? translation(context)
                                                            .support_text
                                                        : translation(context)
                                                            .write_first
                                                    : state.chats[index]
                                                            .last_message?[
                                                        'content'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (state is ChatListGetting) {
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
                            child: Text(translation(context).empty),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
