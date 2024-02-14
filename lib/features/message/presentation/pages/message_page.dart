// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/block_user/presentation/widgets/show_block.dart';
import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:tanysu/features/message/data/models/message_model.dart';
import 'package:tanysu/features/message/presentation/bloc/message_bloc.dart';
import 'package:tanysu/features/message/presentation/widgets/main_message_block.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_main.dart';
import 'package:tanysu/features/show_gifts/presentation/pages/show_gifts.dart';
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
    Key? key,
    required this.name,
    required this.image,
    required this.chatId,
    required this.userId,
    required this.profileId,
  }) : super(key: key);

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
            "message": textController.text,
            "user_id": widget.userId,
          },
        ),
      );
      textController.text = '';
    }
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
      Uri.parse('wss://tanysu.net/ws/chat/${widget.chatId}/${widget.userId}/'),
    );
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leadingWidth: 300,
        elevation: 0,
        leading: Row(
          children: [
            const SizedBox(width: 20),
            BackButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: () {
                bloc1.add(GetAllChats());
                Navigator.pop(context);
              },
            ),
            GestureDetector(
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
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.image,
                ),
                radius: 20,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.name,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                showBlock(context, widget.name, widget.userId);
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
      body: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/images/message_back.svg',
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
                            // print(messages);
                            return StreamBuilder(
                              stream: channel.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map<String, dynamic> info =
                                      jsonDecode(snapshot.data);
                                  if (info['message'] !=
                                      'You are now connected!') {
                                    print(info);
                                    messages.add(
                                      MessageModel(
                                        chat: widget.chatId,
                                        content: info['message'],
                                        sender: info['user'],
                                        timestamp: info['timestamp'],
                                        is_svg: null,
                                        is_read: false,
                                        id: null,
                                        name: null,
                                        photo: null,
                                        profile_id: null,
                                        profile: null,
                                      ),
                                    );
                                  }
                                }
                                return MainMessageBlock(
                                  userId: widget.userId,
                                  messages: messages,
                                );
                              },
                            );
                          } else if (state is MessageGetting) {
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
                              child: Text(translation(context).chat_get_error),
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showGifts(
                                context,
                                widget.name,
                                widget.profileId,
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/icons/gift_button.svg',
                              height: 36,
                              width: 36,
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Center(
                              child: TextField(
                                cursorHeight: 18,
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                controller: textController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: translation(context).message,
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                onSubmitted: (value) {
                                  sendMessage();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              sendMessage();
                            },
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: secondColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
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