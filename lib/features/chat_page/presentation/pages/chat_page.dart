import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/providers/home_provider.dart';
import 'package:tanysu/features/chat_page/data/models/chat_model.dart';
import 'package:tanysu/features/chat_page/presentation/widgets/chat_tile.dart';
import 'package:tanysu/features/get_user_id/data/repositories/get_user_id_repo.dart';
import 'package:tanysu/features/message/presentation/pages/group_message_page.dart';
import 'package:tanysu/features/message/presentation/pages/message_page.dart';
import 'package:tanysu/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatPageBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ChatPageBloc>(context);
    _startAutoUpdate();
    super.initState();
  }

  Timer? timer;
  void _startAutoUpdate() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      bloc.add(UpdateAllChats());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const GradientText(
          'Tanysu',
          gradient: LinearGradient(
            colors: <Color>[
              mainColor,
              secondColor,
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black12,
          ),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<Box<ChatModel>>(
          valueListenable: Hive.box<ChatModel>('chatBox').listenable(),
          builder: (context, chatBox, widget) {
            final chats = chatBox.values.toList();
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => CupertinoContextMenu(
                enableHapticFeedback: true,
                actions: [
                  CupertinoContextMenuAction(
                    onPressed: () {
                      bloc.add(
                        DeleteChat(chatId: chats[index].id),
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      translation(context).delete,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ),
                ],
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CupertinoButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    onPressed: () async {
                      int? profile = await getProfileModel();
                      if (chats[index].chat_type == 'public') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => HomeProvider(),
                              child: PublicMessagePage(
                                name: chats[index].chat_name ?? '',
                                image: chats[index].chat_photo ?? '',
                                chatId: chats[index].id,
                                userId: profile ?? 0,
                              ),
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => HomeProvider(),
                              child: MessagePage(
                                name: chats[index].chat_name ?? '',
                                image: chats[index].chat_photo ?? '',
                                chatId: chats[index].id,
                                userId: profile ?? 0,
                                profileId: chats[index].profile_id ?? 0,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: ChatTile(
                      chatData: chats[index],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<int?> getProfileModel() async {
    GetUserIdRepo repository = GetUserIdRepo();
    int? profileModel = await repository.getUserId();
    return profileModel;
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserratAlternates(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
