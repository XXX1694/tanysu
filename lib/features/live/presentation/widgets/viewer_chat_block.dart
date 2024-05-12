import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/live/data/models/stream_message_model.dart';
import 'package:tanysu/features/live/presentation/widgets/viewer_message_field.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ViewerChatBlock extends StatefulWidget {
  const ViewerChatBlock({
    super.key,
    required this.profileId,
    required this.roomId,
  });

  final int profileId;
  final String roomId;

  @override
  State<ViewerChatBlock> createState() => _ViewerChatBlockState();
}

class _ViewerChatBlockState extends State<ViewerChatBlock> {
  late WebSocketChannel channel;
  late TextEditingController messageController;
  late List<StreamMessageModel> messages;
  @override
  void initState() {
    messageController = TextEditingController();
    messages = [];
    channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://tanysu.net/ws/stream/${widget.profileId}/${widget.roomId}/'),
    );
    super.initState();
  }

  sendMeaasge() {
    if (messageController.text.isNotEmpty) {
      channel.sink.add(
        jsonEncode(
          {
            "type": "chat_message",
            "message": messageController.text,
            "profile_id": widget.profileId,
            "name": 'Test_user'
          },
        ),
      );
      messageController.text = '';
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: deviceHeight * 0.3,
      child: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print(snapshot.data);
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) => MessageItem(
                      imageUrl: messages[index].photo ?? '',
                      message: messages[index].message ?? '',
                      name: messages[index].name ?? '',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ViewerMessageField(
                  sendMessageFunction: sendMeaasge,
                  sendGiftFunction: () {},
                  messageController: messageController,
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.imageUrl,
    required this.message,
    required this.name,
  });
  final String imageUrl;
  final String name;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    color: Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    message,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
