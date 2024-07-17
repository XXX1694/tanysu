import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/core/constants/chats.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/providers/home_provider.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/message/presentation/pages/group_message_page.dart';
import 'package:tanysu/features/message/presentation/pages/message_page.dart';
import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:tanysu/features/get_user_id/presentation/bloc/get_user_id_bloc.dart';
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
  Timer? timer;
  int userId = 0;
  @override
  void initState() {
    bloc = BlocProvider.of<ChatPageBloc>(context);
    bloc1 = BlocProvider.of<GetUserIdBloc>(context);
    bloc1.add(GetuserId());
    bloc.add(GetAllChats());
    _startAutoUpdate();
    super.initState();
  }

  void _startAutoUpdate() {
    timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      bloc.add(UpdateAllChats());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'PANDEYA',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black,
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<GetUserIdBloc, GetUserIdState>(
            builder: (context, state1) {
              return BlocConsumer<ChatPageBloc, ChatPageState>(
                listener: (context, state) {
                  if (kDebugMode) {
                    print(state);
                  }
                  if (state is ChatListGot || state is ChatListGetError) {
                    _refreshController.refreshCompleted();
                  }
                  // if (state is ChatDeleted || state is ChatDeleteError) {
                  //   bloc.add(
                  //     GetAllChats(),
                  //   );
                  // }
                  if (state is ChatListGot && state1 is GotUserId) {
                    setState(() {
                      userId = state1.userId;
                      chats = state.chats;
                    });
                  }
                },
                builder: (context, state) {
                  // WebSocketChannel.connect(
                  //   Uri.parse('wss://tanysu.net/ws/status/$userId/'),
                  // );
                  return SmartRefresher(
                    header: ClassicHeader(
                      textStyle:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black54,
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
                      itemCount: chats.length,
                      itemBuilder: (context, index) => Dismissible(
                        crossAxisEndOffset: 0.5,
                        key: ValueKey(chats[index]),
                        background: Container(
                          color: mainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                translation(context).unmatch,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          Platform.isAndroid
                              ? showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    iconPadding: const EdgeInsets.all(8),
                                    contentPadding: const EdgeInsets.all(8),
                                    insetPadding: const EdgeInsets.all(12),
                                    titlePadding: const EdgeInsets.all(16),
                                    buttonPadding: const EdgeInsets.all(12),
                                    actionsPadding: const EdgeInsets.all(4),
                                    title: Text(
                                      translation(context).delete_chat_main,
                                      textAlign: TextAlign.center,
                                    ),
                                    titleTextStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                    content: Text(
                                      translation(context).delete_chat_second,
                                      textAlign: TextAlign.center,
                                    ),
                                    contentTextStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.black),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            chats.removeAt(index);
                                          });
                                          bloc.add(
                                            DeleteChat(
                                              chatId: chats[index].id,
                                            ),
                                          );
                                        },
                                        child: Text(
                                          translation(context).yes,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: mainColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          translation(context).no,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: Text(
                                      translation(context).delete_chat_main,
                                    ),
                                    content: Text(translation(context)
                                        .delete_chat_second),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            chats.removeAt(index);
                                          });
                                          bloc.add(
                                            DeleteChat(
                                              chatId: chats[index].id,
                                            ),
                                          );
                                        },
                                        child: Text(translation(context).yes),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(translation(context).no),
                                      )
                                    ],
                                  ),
                                );
                        },
                        child: CupertinoButton(
                          padding: EdgeInsets.only(
                            top: index == 0 ? 16 : 0,
                            bottom: 20,
                          ),
                          onPressed: () {
                            if (chats[index].is_public) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (context) => HomeProvider(),
                                    child: PublicMessagePage(
                                      name: chats[index].is_admin_chat
                                          ? translation(context).support
                                          : (chats[index].name ?? ''),
                                      image: chats[index].is_public
                                          ? chats[index].group_photo ?? ''
                                          : chats[index].profile?['image']
                                                  ['image_url'] ??
                                              '',
                                      chatId: chats[index].id,
                                      userId: userId,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (context) => HomeProvider(),
                                    child: MessagePage(
                                      name: chats[index].is_admin_chat
                                          ? translation(context).support
                                          : (chats[index]
                                                  .profile?['first_name'] ??
                                              ''),
                                      image: chats[index].profile?['image']
                                              ['image_url'] ??
                                          '',
                                      chatId: chats[index].id,
                                      userId: userId,
                                      profileId: chats[index].profile?['id'],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: SizedBox(
                            height: 54,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        // fadeInDuration:
                                        //     const Duration(seconds: 0),
                                        // fadeOutDuration:
                                        //     const Duration(seconds: 0),
                                        // fadeInCurve: Curves.linear,
                                        // fadeOutCurve: Curves.linear,
                                        height: 54,
                                        width: 54,
                                        imageUrl: chats[index].is_public
                                            ? chats[index].group_photo ?? ''
                                            : chats[index].profile?['image']
                                                    ['image_url'] ??
                                                '',
                                        placeholder: (context, url) =>
                                            const ShrimerPlaceholder(
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const ErrorPlaceholder(
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                        fit: BoxFit.cover,
                                        cacheKey: chats[index].is_public
                                            ? chats[index].group_photo ?? ''
                                            : chats[index].profile?['image']
                                                    ['image_url'] ??
                                                '', // Optional custom cache key
                                        fadeInDuration: const Duration(
                                            milliseconds:
                                                0), // Optional fade-in duration
                                        maxWidthDiskCache:
                                            500, // Optional maximum width for disk cache
                                        maxHeightDiskCache: 500,
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
                                            color: chats[index].is_admin_chat ||
                                                    chats[index].is_public
                                                ? Colors.transparent
                                                : chats[index].online ?? false
                                                    ? Colors.green
                                                    : Colors.red,
                                            borderRadius: BorderRadius.circular(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              chats[index].is_admin_chat
                                                  ? translation(context).support
                                                  : chats[index].is_public
                                                      ? chats[index].name
                                                      : chats[index].profile?[
                                                              'first_name'] ??
                                                          '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            chats[index].last_message != null
                                                ? DateFormat('HH:mm')
                                                    .format(DateTime.parse(
                                                        chats[index]
                                                                .last_message?[
                                                            'timestamp']))
                                                    .toString()
                                                : '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                  color: Colors.black45,
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
                                                chats[index].last_message ==
                                                        null
                                                    ? chats[index].is_admin_chat
                                                        ? translation(context)
                                                            .support_text
                                                        : translation(context)
                                                            .write_first
                                                    : chats[index]
                                                            .last_message?[
                                                        'content'],
                                                // maxLines: 2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.black54,
                                                    ),
                                                // overflow:
                                                //     TextOverflow.clip,
                                              ),
                                            ),
                                            chats[index].unread != null &&
                                                    chats[index].unread != 0
                                                ? Container(
                                                    height: 24,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        100,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        chats[index]
                                                            .unread
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium
                                                            ?.copyWith(
                                                              color:
                                                                  Colors.white,
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
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
