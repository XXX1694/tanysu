import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanysu/core/constants/chats.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/functions/generate_string.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/features/profile_page/data/repositories/profile_page_repository.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';
import 'package:tanysu/features/stream/presentation/bloc/stream_bloc.dart';
import 'package:tanysu/features/stream/presentation/pages/allow_page.dart';
import 'package:tanysu/features/stream/presentation/pages/live_page.dart';
import 'package:tanysu/features/stream/presentation/pages/stream_new.dart';
import 'package:tanysu/l10n/translate.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  late StreamBloc _streamBloc;

  Timer? timer;
  @override
  void initState() {
    _streamBloc = BlocProvider.of<StreamBloc>(context);
    _startAutoUpdate();
    super.initState();
  }

  void _startAutoUpdate() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _streamBloc.add(UpdateAllStream());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        actions: const [],
      ),
      body: BlocConsumer<StreamBloc, StreamState>(
        listener: (context, state) {
          if (state is StreamListGot) {
            setState(() {
              streamListGlobal = state.streamList;
            });
          }
        },
        builder: (context, state) {
          if (state is StreamListGot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                itemCount: streamListGlobal.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    ProfileModel? profileModel = await getProfileModel();
                    jumpToLivePage(
                      context,
                      profileId: profileModel?.id ?? 0,
                      name: profileModel?.first_name ?? 'Без имени',
                      isHost: false,
                      roomID: state.streamList[index].room_id ?? '',
                    );
                  },
                  child: Container(
                    margin: index == 1 || index == 0
                        ? const EdgeInsets.only(
                            top: 12,
                          )
                        : null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            streamListGlobal[index].profile?['image']
                                    ['image_url'] ??
                                '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Colors.black, Colors.transparent],
                              end: Alignment.center,
                              begin: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/stream/eye_24.svg',
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    streamListGlobal[index]
                                        .spectators
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.red.withOpacity(0.9),
                                    ),
                                    child: Text(
                                      'LIVE',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${streamListGlobal[index].profile?['first_name']}, ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        TextSpan(
                                          text: streamListGlobal[index]
                                                  .profile?['age']
                                                  .toString() ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    streamListGlobal[index].description ??
                                        'Без описание',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: Colors.white70,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is StreamListGetting) {
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
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    translation(context).no_live_stream,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    translation(context).be_first,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  const Spacer(),
                  MainButton(
                    text: translation(context).go_live,
                    onPressed: () async {
                      ProfileModel? profileModel = await getProfileModel();
                      newStream(
                        context,
                        isHost: true,
                        profileId: profileModel?.id ?? 0,
                        name: profileModel?.first_name ?? 'Без имени',
                      );
                    },
                    status: 'active',
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<ProfileModel?> getProfileModel() async {
    ProfileRepository repository = ProfileRepository();
    ProfileModel? profileModel = await repository.getMyData();
    return profileModel;
  }

  jumpToLivePage(
    BuildContext context, {
    required bool isHost,
    required int profileId,
    required String name,
    required String roomID,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          liveID: roomID,
          name: name,
          profileId: profileId,
          isHost: isHost,
        ),
      ),
    );
  }

  newStream(
    BuildContext context, {
    required bool isHost,
    required int profileId,
    required String name,
  }) async {
    var statusCamera = await Permission.camera.status;
    var statusMicrophone = await Permission.microphone.status;
    if (statusMicrophone.isGranted && statusCamera.isGranted) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => LivePage(
      //       liveID: generateUniqueId(16),
      //       name: name,
      //       profileId: profileId,
      //       isHost: isHost,
      //     ),
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StreamingPage(
            liveID: generateUniqueId(16),
            name: name,
            profileId: profileId,
            isHost: isHost,
          ),
        ),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AllowPage(
            liveID: generateUniqueId(16),
            name: name,
            profileId: profileId,
            isHost: isHost,
          ),
        ),
        (context) => false,
      );
    }
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
