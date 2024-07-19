import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/block_user/presentation/widgets/show_block.dart';
import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:tanysu/features/message/data/models/message_model.dart';
import 'package:tanysu/features/message/presentation/bloc/message_bloc.dart';
import 'package:tanysu/features/message/presentation/widgets/main_message_block.dart';
import 'package:tanysu/features/message/presentation/widgets/message_field.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_main.dart';
import 'package:tanysu/l10n/translate.dart';

// ignore: depend_on_referenced_packages
import 'package:web_socket_channel/web_socket_channel.dart';

class MessagePage extends StatefulWidget {
  final String name;
  final String image;
  final int chatId;
  final int userId;
  final int profileId;
  const MessagePage({
    super.key,
    required this.name,
    required this.image,
    required this.chatId,
    required this.userId,
    required this.profileId,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late TextEditingController textController;
  late WebSocketChannel channel;
  late MessageBloc bloc;
  late ChatPageBloc bloc1;
  late List<MessageModel> messages;
  void sendMessage() {
    if (textController.text.isNotEmpty) {
      channel.sink.add(
        jsonEncode(
          {
            "type": "chat_message",
            "message": textController.text,
            "user_id": widget.userId,
          },
        ),
      );
      // print(
      //   jsonEncode(
      //     {
      //       "type": "chat_message",
      //       "message": textController.text,
      //       "user_id": widget.userId,
      //     },
      //   ),
      // );
      textController.text = '';
    }
  }

  void sendGift({required int giftId}) {
    channel.sink.add(
      jsonEncode(
        {
          "type": "send_gift",
          "message": giftId,
          "user_id": widget.userId,
        },
      ),
    );
    // print('send gift function activated!');
    // print(
    //   jsonEncode(
    //     {
    //       "type": "send_gift",
    //       "message": giftId,
    //       "user_id": widget.userId,
    //     },
    //   ),
    // );
  }

  void deleteMessage(
    int messageId,
    int userId,
  ) {
    channel.sink.add(
      jsonEncode(
        {
          'type': 'delete',
          'message_id': messageId,
          'user_id': userId,
        },
      ),
    );
    messages.removeWhere((item) => (item.id ?? 0) == messageId);
  }

  // void readed(int messageId) {
  //   channel.sink.add(
  //     jsonEncode(
  //       {
  //         "type": "mark_as_read",
  //         "message_id": messageId,
  //       },
  //     ),
  //   );
  // }

  // chatSocket.send(JSON.stringify({
  //               'type': 'mark_as_read',
  //               'message_id': messageId
  //           }));

  @override
  void initState() {
    messages = [];
    bloc = BlocProvider.of<MessageBloc>(context);
    bloc1 = BlocProvider.of<ChatPageBloc>(context);
    bloc.add(GetAllMessages(chatId: widget.chatId));
    channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://tanysu.net/ws/v3/chat/${widget.chatId}/${widget.userId}/'),
    );
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePreviewPageMain(
                  profileId: widget.profileId,
                  controller: null,
                ),
              ),
            );
          },
          child: Text(
            widget.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                showBlockIOS(context, widget.name, widget.userId);
              },
              child: SvgPicture.asset(
                'assets/icons/info.svg',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black26,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/background/chat_background.svg',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<MessageBloc, MessageState>(
                      builder: (context, state) {
                        if (state is MessageGot) {
                          messages = state.messages;
                          return StreamBuilder(
                            stream: channel.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Map<String, dynamic> info =
                                    jsonDecode(snapshot.data);
                                debugPrint(info.toString());
                                if (info['message_type'] == 'chat_message') {
                                  messages.add(
                                    MessageModel(
                                      chat: widget.chatId,
                                      content: '${info['message']}',
                                      sender: info['user'],
                                      timestamp: info['timestamp'],
                                      message_type: info['message_type'],
                                      is_read: false,
                                      id: info['message_id'] ?? 0,
                                      name: info['name'] ?? '',
                                      photo: info['photo'] ?? '',
                                      profile_id: info['profile_id'] ?? 0,
                                      is_svg: false,
                                    ),
                                  );
                                } else {
                                  messages.add(
                                    MessageModel(
                                      chat: widget.chatId,
                                      content: '${info['message']}',
                                      sender: info['user'],
                                      timestamp: info['timestamp'],
                                      message_type: info['message_type'],
                                      is_read: false,
                                      id: info['message_id'] ?? 0,
                                      name: info['name'] ?? '',
                                      photo: info['photo'] ?? '',
                                      profile_id: info['profile_id'] ?? 0,
                                      is_svg: true,
                                    ),
                                  );
                                }
                              }
                              return MainMessageBlock(
                                userId: widget.userId,
                                messages: messages,
                                deleteMessageFunction: deleteMessage,
                              );
                            },
                          );
                        } else if (state is MessageGetting) {
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
                        } else {
                          return Center(
                            child: Text(translation(context).chat_get_error),
                          );
                        }
                      },
                    ),
                  ),
                  MessageField(
                    sendMessageFunction: sendMessage,
                    sendGiftFunction: sendGift,
                    messageController: textController,
                    profileId: widget.profileId,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.add(Reset());
    channel.sink.close();
    textController.dispose();
    super.dispose();
  }
}
