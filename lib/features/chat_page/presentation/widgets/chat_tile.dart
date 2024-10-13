import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/chat_page/data/models/chat_model.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chatData});
  final ChatModel chatData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              chatData.chat_type == 'usual'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        fadeInDuration: const Duration(seconds: 0),
                        fadeOutDuration: const Duration(seconds: 0),
                        fadeInCurve: Curves.linear,
                        fadeOutCurve: Curves.linear,
                        height: 54,
                        width: 54,
                        imageUrl: chatData.chat_photo ?? '',
                        placeholder: (context, url) => const ShrimerPlaceholder(
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        errorWidget: (context, url, error) =>
                            const ErrorPlaceholder(
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        fit: BoxFit.cover,
                      ),
                    )
                  : chatData.chat_type == 'public'
                      ? Image.asset(
                          'assets/images/chat_image.jpg',
                          height: 54,
                          width: 54,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/support_image.jpg',
                            height: 54,
                            width: 54,
                          ),
                        ),
              chatData.chat_type == 'usual'
                  ? Positioned(
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: chatData.chat_type == 'private'
                                ? Colors.transparent
                                : chatData.online ?? false
                                    ? Colors.green
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(
                              100,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chatData.chat_name ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    chatData.last_message_time != null ||
                            chatData.last_message_time.toString() == ""
                        ? Text(
                            formatDate(
                                chatData.last_message_time ?? DateTime.now()),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : const SizedBox(),
                  ],
                ),
                Text(
                  chatData.last_message ?? '',
                  // maxLines: 2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                      ),
                ),
                const Spacer(),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final difference = today
      .difference(DateTime(dateTime.year, dateTime.month, dateTime.day))
      .inDays;

  // If the message is from today
  if (difference == 0) {
    return DateFormat('HH:mm').format(dateTime); // Show time if it's today
  }
  // If the message is within the last week
  else if (difference > 0 && difference <= 7) {
    return DateFormat('EEEE').format(dateTime); // Show the day of the week
  }
  // Else, show the date in dd.MM.yyyy format
  else {
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }
}
