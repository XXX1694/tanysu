import 'dart:io';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/constants/gifts.dart';
import 'package:tanysu/features/message/data/models/message_model.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_main.dart';
import 'package:tanysu/l10n/translate.dart';

class GroupMessageBlock extends StatelessWidget {
  const GroupMessageBlock({
    super.key,
    required this.userId,
    required this.messages,
    required this.deleteMessageFunction,
    required this.scrollController,
  });
  final int userId;
  final List<MessageModel> messages;
  final Function(int, int) deleteMessageFunction;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<MessageModel, DateTime>(
      reverse: true,
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      floatingHeader: true,
      shrinkWrap: true,
      elements: messages,
      groupBy: (message) {
        DateTime time = DateTime.parse(message.timestamp ?? '');
        return DateTime(
          time.year,
          time.month,
          time.day,
          time.hour,
          time.minute,
          time.second,
        );
      },
      sort: true,
      controller: scrollController,
      groupHeaderBuilder: (MessageModel message) => const SizedBox(),
      indexedItemBuilder: (context, MessageModel message, int index) {
        if (index < messages.length - 1) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: (message.sender ?? 0) == userId
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: (message.sender ?? 0) == userId
                  ? MyMessage(
                      message: message,
                      deleteMessageFunction: deleteMessageFunction,
                    )
                  : OtherMessage(
                      message: message,
                    ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Platform.isAndroid
                  ? SizedBox(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                        color: secondColor,
                        strokeWidth: 2,
                      ),
                    )
                  : CupertinoActivityIndicator(
                      color: secondColor,
                    ),
            ),
          );
        }
      },
    );
  }
}

class MyMessage extends StatelessWidget {
  const MyMessage({
    super.key,
    required this.message,
    required this.deleteMessageFunction,
  });
  final MessageModel message;
  final Function(int, int) deleteMessageFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: CupertinoContextMenu(
        enableHapticFeedback: true,
        actions: [
          CupertinoContextMenuAction(
            onPressed: () {
              deleteMessageFunction(
                message.id ?? 0,
                message.sender ?? 0,
              );
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translation(context).delete,
                  style: GoogleFonts.montserrat(
                    color: Colors.red,
                    // fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.41,
                  ),
                ),
                const Icon(
                  Icons.delete,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ],
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85),
          // margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: accentColor50w,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(2, 2),
                blurRadius: 15,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: message.message_type == 'send_gift'
                ? Row(
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: SvgPicture.network(
                          message.content ?? '',
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              message.content ?? '',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat.Hm().format(
                              DateTime.parse(message.timestamp ?? ''),
                            ),
                            style: GoogleFonts.montserrat(
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class OtherMessage extends StatelessWidget {
  const OtherMessage({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final AppinioSwiperController cardController = AppinioSwiperController();
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePreviewPageMain(
                    profileId: message.profile_id ?? 0,
                    controller: cardController,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(height: 4),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    message.photo ?? '',
                  ),
                  radius: 20,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: message.message_type == 'send_gift'
                ? Row(
                    children: [
                      SvgPicture.asset(
                        gifts[int.parse(message.content ?? '0')],
                        height: 60,
                        width: 60,
                      ),
                      const Spacer(),
                    ],
                  )
                : Container(
                    // margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(2, 2),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.name ?? '',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  message.content ?? '',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat.Hm().format(
                                  DateTime.parse(message.timestamp ?? ''),
                                ),
                                style: GoogleFonts.montserrat(
                                  color: Colors.black54,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
