import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/message/data/models/message_model.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_main.dart';

class GroupMessageBlock extends StatelessWidget {
  const GroupMessageBlock(
      {super.key, required this.userId, required this.messages});
  final int userId;
  final List<MessageModel> messages;

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
        return DateTime(time.year, time.month, time.day, time.hour, time.minute,
            time.second);
      },
      sort: true,
      groupHeaderBuilder: (MessageModel message) => const SizedBox(),
      itemBuilder: (context, MessageModel message) => Align(
        alignment: (message.sender ?? 0) == userId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: (message.sender ?? 0) == userId
            ? MyMessage(
                content: message.content ?? '',
                time: message.timestamp ?? '',
                isSvg: message.is_svg ?? false,
              )
            : OtherMessage(
                sender: message.sender ?? 0,
                content: message.content ?? '',
                image: message.photo ?? '',
                name: message.name ?? 'noname',
                time: message.timestamp ?? '',
                profileId: message.profile_id ?? 0,
                isSvg: message.is_svg ?? false,
              ),
      ),
    );
  }
}

class MyMessage extends StatelessWidget {
  const MyMessage({
    super.key,
    required this.content,
    required this.time,
    required this.isSvg,
  });
  final String content;
  final String time;
  final bool isSvg;
  @override
  Widget build(BuildContext context) {
    return isSvg
        ? Row(
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.network(
                  content,
                  height: 60,
                  width: 60,
                ),
              ),
            ],
          )
        : Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: accentColor20,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          content,
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
                          DateTime.parse(time),
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
          );
  }
}

class OtherMessage extends StatelessWidget {
  const OtherMessage({
    super.key,
    required this.sender,
    required this.content,
    required this.image,
    required this.name,
    required this.time,
    required this.profileId,
    required this.isSvg,
  });
  final int sender;
  final String content;
  final String name;
  final String image;
  final String time;
  final int profileId;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    final AppinioSwiperController cardController = AppinioSwiperController();
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePreviewPageMain(
                    profileId: profileId,
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
                    image,
                  ),
                  radius: 16,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: isSvg
                ? Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: SvgPicture.network(
                          content,
                          height: 60,
                          width: 60,
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: secondColor20,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  content,
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
                                  DateTime.parse(time),
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
