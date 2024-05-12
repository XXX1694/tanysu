import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/like_page/data/models/like_person.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview.dart';
import 'package:tanysu/l10n/translate.dart';

class LikesList extends StatelessWidget {
  const LikesList({
    super.key,
    required this.list,
    required this.reloadFunc,
    required this.refreshController,
  });
  final List<LikePersonModel> list;
  final Function reloadFunc;
  final RefreshController refreshController;
  @override
  Widget build(BuildContext context) {
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
      controller: refreshController,
      onRefresh: () {
        reloadFunc();
      },
      child: GridView.builder(
        itemCount: list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 15 / 20,
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePreviewPageBasic(
                  profileId: list[index].id ?? 0,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(
              top: index == 0 || index == 1 ? 12.0 : 0,
              bottom: index == list.length - 2 || index == list.length - 1
                  ? 12.0
                  : 0,
            ),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: list[index].image!.containsKey('image_url')
                      ? CachedNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          imageUrl: list[index].image!['image_url'],
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
                        )
                      : Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: list[index].online ?? false
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${list[index].first_name ?? ''}, ${list[index].age ?? 0}',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
