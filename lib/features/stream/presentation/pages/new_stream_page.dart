import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/functions/generate_string.dart';
import 'package:tanysu/features/profile_page/presentation/bloc/profile_page_bloc.dart';
import 'package:tanysu/features/stream/presentation/pages/live_page.dart';

class NewStreamPage extends StatefulWidget {
  const NewStreamPage({super.key});

  @override
  State<NewStreamPage> createState() => _NewStreamPageState();
}

class _NewStreamPageState extends State<NewStreamPage> {
  late ProfilePageBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProfilePageBloc>(context);
    bloc.add(GetMyData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ProfilePageBloc, ProfilePageState>(
        listener: (context, state) {
          if (state is ProfileGot) {
            jumpToLivePage(
              context,
              isHost: true,
              profileId: state.model.id ?? 0,
              name: state.model.first_name ?? 'Noname',
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Platform.isAndroid
                ? const CircularProgressIndicator(
                    color: mainColor,
                    strokeWidth: 3,
                  )
                : const CupertinoActivityIndicator(
                    color: mainColor,
                  ),
          );
        },
      ),
    );
  }

  jumpToLivePage(
    BuildContext context, {
    required bool isHost,
    required int profileId,
    required String name,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          liveID: generateUniqueId(16),
          name: name,
          profileId: profileId,
          isHost: isHost,
        ),
      ),
    );
  }
}
