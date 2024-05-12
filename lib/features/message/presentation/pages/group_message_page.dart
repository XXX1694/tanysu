import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:tanysu/features/message/data/models/message_model.dart';
import 'package:tanysu/features/message/presentation/bloc/message_bloc.dart';
import 'package:tanysu/features/message/presentation/widgets/group_message_block.dart';
import 'package:tanysu/features/message/presentation/widgets/group_message_field.dart';

// ignore: depend_on_referenced_packages
import 'package:web_socket_channel/web_socket_channel.dart';

class PublicMessagePage extends StatefulWidget {
  final String name;
  final String image;
  final int chatId;
  final int userId;
  const PublicMessagePage({
    Key? key,
    required this.name,
    required this.image,
    required this.chatId,
    required this.userId,
  }) : super(key: key);

  @override
  State<PublicMessagePage> createState() => _PublicMessagePageState();
}

class _PublicMessagePageState extends State<PublicMessagePage> {
  late TextEditingController textController;
  late WebSocketChannel channel;
  late MessageBloc bloc;
  late ChatPageBloc bloc1;
  late List<MessageModel> messages = [];
  late ScrollController _scrollController;
  int page = 1;
  void sendMessage() {
    if (textController.text.isNotEmpty) {
      channel.sink.add(
        jsonEncode(
          {
            "type": "message",
            "message": textController.text,
            "user_id": widget.userId,
          },
        ),
      );
      textController.text = '';
    }
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

  void reload() {
    bloc.add(GetAllGroupMessages(page: page));
  }

  @override
  void initState() {
    messages = [];
    bloc = BlocProvider.of<MessageBloc>(context);
    bloc1 = BlocProvider.of<ChatPageBloc>(context);
    page = 1;
    reload();
    channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://tanysu.net/ws/v3/chat/${widget.chatId}/${widget.userId}/'),
    );
    textController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.offset) {
          page++;
          reload();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 50,
        elevation: 0,
        leading: Row(
          children: [
            const SizedBox(width: 12),
            InkWell(
              child: SvgPicture.asset('assets/icons/back_button.svg'),
              onTap: () {
                bloc1.add(GetAllChats());
                Navigator.pop(context);
              },
            ),
            const Spacer(),
          ],
        ),
        centerTitle: true,
        title: Text(
          widget.name,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black12,
          ),
        ),
      ),
      body: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/background/message_background_pattern.svg',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: BlocConsumer<MessageBloc, MessageState>(
                        listener: (context, state) {
                          if (state is MessageGot) {
                            messages += state.messages;
                          }
                        },
                        builder: (context, state) {
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
                                      content: info['message'],
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
                                }
                              }
                              return GroupMessageBlock(
                                userId: widget.userId,
                                messages: messages,
                                deleteMessageFunction: deleteMessage,
                                scrollController: _scrollController,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    GroupMessageField(
                      controller: textController,
                      sendMessageFunction: sendMessage,
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
