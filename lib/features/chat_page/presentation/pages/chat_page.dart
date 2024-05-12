import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/providers/home_provider.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/message/presentation/pages/group_message_page.dart';
import 'package:tanysu/features/message/presentation/pages/message_page.dart';
import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:tanysu/features/get_user_id/presentation/bloc/get_user_id_bloc.dart';
import 'package:tanysu/l10n/translate.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'tanysu',
          style: GoogleFonts.montserratAlternates(
            color: mainColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
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
                    WebSocketChannel.connect(
                      Uri.parse('wss://tanysu.net/ws/status/${state1.userId}/'),
                    );
                    return SmartRefresher(
                      header: ClassicHeader(
                        textStyle: GoogleFonts.montserrat(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  translation(context).unmatch,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
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
                            padding: EdgeInsets.only(
                              top: index == 0 ? 16 : 0,
                              bottom: 20,
                            ),
                            onPressed: () {
                              if (state.chats[index].is_public) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                      create: (context) => HomeProvider(),
                                      child: PublicMessagePage(
                                        name: state.chats[index].is_admin_chat
                                            ? translation(context).support
                                            : (state.chats[index].name ?? ''),
                                        image: state.chats[index].is_public
                                            ? state.chats[index].group_photo ??
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
                                        name: state.chats[index].is_admin_chat
                                            ? translation(context).support
                                            : (state.chats[index]
                                                    .profile?['first_name'] ??
                                                ''),
                                        image:
                                            state.chats[index].profile?['image']
                                                    ['image_url'] ??
                                                '',
                                        chatId: state.chats[index].id,
                                        userId: state1.userId,
                                        profileId:
                                            state.chats[index].profile?['id'],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 56,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              height: 54,
                                              width: 54,
                                              imageUrl: state
                                                      .chats[index].is_public
                                                  ? state.chats[index]
                                                          .group_photo ??
                                                      ''
                                                  : state.chats[index]
                                                              .profile?['image']
                                                          ['image_url'] ??
                                                      '',
                                              placeholder: (context, url) =>
                                                  const ShrimerPlaceholder(
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const ErrorPlaceholder(
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                  color: state.chats[index]
                                                              .is_admin_chat ||
                                                          state.chats[index]
                                                              .is_public
                                                      ? Colors.transparent
                                                      : state.chats[index]
                                                                  .online ??
                                                              false
                                                          ? Colors.green
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    100,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                                                Expanded(
                                                  child: Text(
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  state.chats[index]
                                                              .last_message !=
                                                          null
                                                      ? DateFormat('HH:mm')
                                                          .format(DateTime.parse(
                                                              state.chats[index]
                                                                      .last_message?[
                                                                  'timestamp']))
                                                          .toString()
                                                      : '',
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      state.chats[index]
                                                                  .last_message ==
                                                              null
                                                          ? state.chats[index]
                                                                  .is_admin_chat
                                                              ? translation(
                                                                      context)
                                                                  .support_text
                                                              : translation(
                                                                      context)
                                                                  .write_first
                                                          : state.chats[index]
                                                                  .last_message?[
                                                              'content'],
                                                      // maxLines: 2,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                      // overflow:
                                                      //     TextOverflow.clip,
                                                    ),
                                                  ),
                                                  state.chats[index].unread !=
                                                              null &&
                                                          state.chats[index]
                                                                  .unread !=
                                                              0
                                                      ? Container(
                                                          height: 24,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 8,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: mainColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              100,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              state.chats[index]
                                                                  .unread
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox(
                                                          width: 32,
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
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
      ),
    );
  }
}
