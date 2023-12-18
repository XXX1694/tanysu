import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/common/functions/show_snack_bar.dart';
import 'package:tanysu/features/show_gifts/presentation/bloc/show_gifts_bloc.dart';

Future showGifts(BuildContext context, String userName) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) => Gifts(userName: userName),
  );
}

class Gifts extends StatefulWidget {
  const Gifts({super.key, required this.userName});
  final String userName;
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
    return BlocConsumer<ShowGiftsBloc, ShowGiftsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GotGifts) {
          return Container(
            height: size.height * 0.48,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
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
                        itemCount: state.gifts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (context, index) => CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pop(context);
                            showSnackBar(context, 'Подарок отправлен');
                          },
                          child: Column(
                            children: [
                              SvgPicture.network(
                                state.gifts[index]['svg_file'],
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    double.parse(state.gifts[index]['price'])
                                        .round()
                                        .toString(),
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
        } else if (state is GettingGifts) {
          return Container(
            height: size.height * 0.48,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Platform.isAndroid
                          ? CircularProgressIndicator(
                              color: secondColor,
                              strokeWidth: 3,
                            )
                          : CupertinoActivityIndicator(
                              color: secondColor,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: size.height * 0.48,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Platform.isAndroid
                          ? CircularProgressIndicator(
                              color: secondColor,
                              strokeWidth: 3,
                            )
                          : CupertinoActivityIndicator(
                              color: secondColor,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
