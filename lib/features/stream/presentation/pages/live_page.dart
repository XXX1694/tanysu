import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/features/block_user/presentation/widgets/show_block.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;
  final String name;
  final int profileId;

  const LivePage({
    super.key,
    required this.liveID,
    this.isHost = false,
    required this.name,
    required this.profileId,
  });

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  late WebSocketChannel channel;

  @override
  void initState() {
    if (kDebugMode) {
      print('wss://tanysu.net/ws/stream/${widget.profileId}/${widget.liveID}/');
    }
    channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://tanysu.net/ws/stream/${widget.profileId}/${widget.liveID}/'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print(snapshot.data);
            }
            return SafeArea(
              child: Stack(
                children: [
                  ZegoUIKitPrebuiltLiveStreaming(
                    appID:
                        928839839, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
                    appSign:
                        '79b4d4ff45ecc941b89e9755e20d8ce9ded2a6c8316585a61c45731d7c97bd1f', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
                    userID: widget.profileId.toString(),
                    userName: widget.name,
                    liveID: widget.liveID,
                    config: widget.isHost
                        ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
                        : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
                  ),
                  !widget.isHost
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 24,
                            ),
                            child: GestureDetector(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/more.svg',
                                    height: 15,
                                  ),
                                ),
                              ),
                              onTap: () {
                                showBlockIOS(
                                  context,
                                  widget.name,
                                  widget.profileId,
                                );
                              },
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Создание стрима...'),
            );
          }
        },
      ),
    );
  }
}
