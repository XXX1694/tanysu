import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/constants/gifts.dart';
import 'package:tanysu/features/show_gifts/presentation/bloc/show_gifts_bloc.dart';

Future showChatGifts(
  BuildContext context,
  int profileId,
  Function({required int giftId}) sendGift,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) => Gifts(
      profileId: profileId,
      sendGift: sendGift,
    ),
  );
}

class Gifts extends StatefulWidget {
  const Gifts({
    super.key,
    required this.profileId,
    required this.sendGift,
  });
  final int profileId;
  final Function({required int giftId}) sendGift;
  @override
  State<Gifts> createState() => _GiftsState();
}

class _GiftsState extends State<Gifts> {
  late ShowGiftsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ShowGiftsBloc>(context);
    bloc.add(GetGifts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.48,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: SafeArea(
                child: GridView.builder(
                  itemCount: gifts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 80,
                  ),
                  itemBuilder: (context, index) => CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      widget.sendGift(giftId: index);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          gifts[index],
                          width: 48,
                          height: 48,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '0',
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              'assets/icons/coin.svg',
                              height: 16,
                              width: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
