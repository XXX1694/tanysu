import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/constants/gifts.dart';
import 'package:tanysu/features/message/data/models/message_model.dart';
import 'package:tanysu/l10n/translate.dart';

class MainMessageBlock extends StatelessWidget {
  const MainMessageBlock({
    super.key,
    required this.userId,
    required this.messages,
    required this.deleteMessageFunction,
  });
  final int userId;
  final List<MessageModel> messages;
  final Function(int, int) deleteMessageFunction;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<MessageModel, DateTime>(
      reverse: true,
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      floatingHeader: true,
      elements: messages,
      groupBy: (message) {
        DateTime time = DateTime.parse(message.timestamp ?? '');
        return DateTime(time.year, time.month, time.day);
      },
      groupHeaderBuilder: (MessageModel message) => SizedBox(
        height: 40,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Text(
                DateFormat.yMMMd().format(
                  DateTime.parse(message.timestamp ?? ''),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      itemBuilder: (context, MessageModel message) => Padding(
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
      ),
      // Padding(
      //   padding: const EdgeInsets.only(bottom: 8),
      //   child: Align(
      //     alignment: (message.sender ?? 0) == userId
      //         ? Alignment.centerRight
      //         : Alignment.centerLeft,
      //     child: message.is_svg ?? false
      //         ? Row(
      //             children: [
      //               message.sender != userId
      //                   ? const SizedBox()
      //                   : const Spacer(),
      //               SvgPicture.network(
      //                 message.content ?? '',
      //                 height: 60,
      //                 width: 60,
      //               ),
      //               message.sender == userId
      //                   ? const SizedBox()
      //                   : const Spacer(),
      //             ],
      //           )
      //         : Container(
      //             decoration: BoxDecoration(
      //               color: message.sender == userId
      //                   ? accentColor50w
      //                   : Colors.white,
      //               borderRadius: BorderRadius.only(
      //                 topLeft: const Radius.circular(12),
      //                 topRight: const Radius.circular(12),
      //                 bottomLeft: (message.sender ?? 0) == userId
      //                     ? const Radius.circular(12)
      //                     : const Radius.circular(0),
      //                 bottomRight: (message.sender ?? 0) != userId
      //                     ? const Radius.circular(12)
      //                     : const Radius.circular(0),
      //               ),
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.black.withOpacity(0.05),
      //                   offset: const Offset(2, 2),
      //                   blurRadius: 15,
      //                 ),
      //               ],
      //             ),
      //             child: Padding(
      //               padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 crossAxisAlignment: CrossAxisAlignment.end,
      //                 children: [
      //                   ConstrainedBox(
      //                     constraints: BoxConstraints(
      //                         maxWidth:
      //                             MediaQuery.of(context).size.width * 0.55),
      //                     child: Text(
      //                       '${message.content}',
      //                       style: GoogleFonts.montserrat(
      //                         color: Colors.black,
      //                         fontSize: 14,
      //                         height: 1.2,
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(width: 8),
      //                   Text(
      //                     DateFormat.Hm().format(
      //                       DateTime.parse(
      //                         message.timestamp ?? '',
      //                       ),
      //                     ),
      //                     style: GoogleFonts.montserrat(
      //                       color: Colors.black54,
      //                       fontSize: 10,
      //                     ),
      //                   ),
      //                   message.sender == userId
      //                       ? const SizedBox(width: 8)
      //                       : const SizedBox(),
      //                   message.sender == userId
      //                       ? !(message.is_read ?? false)
      //                           ? SvgPicture.asset('assets/icons/sended.svg')
      //                           : SvgPicture.asset('assets/icons/readed.svg')
      //                       : const SizedBox(),
      //                 ],
      //               ),
      //             ),
      //           ),
      //   ),
      // ),
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.red,
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
            color: accentColor20,
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
            child: message.message_type == 'send_gift' || message.is_svg
                ? SvgPicture.asset(
                    gifts[int.parse(message.content.toString())],
                    height: 60,
                    width: 60,
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat.Hm().format(
                              DateTime.parse(message.timestamp ?? ''),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Colors.black54,
                                ),
                          ),
                          const SizedBox(width: 8),
                          !(message.is_read ?? false)
                              ? SvgPicture.asset('assets/icons/sended.svg')
                              : SvgPicture.asset('assets/icons/readed.svg')
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
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
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
        child: message.message_type == 'send_gift' || message.is_svg
            ? SvgPicture.asset(
                gifts[int.parse(message.content.toString())],
                height: 60,
                width: 60,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.name ?? '',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          message.content ?? '',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat.Hm().format(
                          DateTime.parse(message.timestamp ?? ''),
                        ),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
