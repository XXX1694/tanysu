import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;
  final String name;
  final int profileId;

  const LivePage({
    Key? key,
    required this.liveID,
    this.isHost = false,
    required this.name,
    required this.profileId,
  }) : super(key: key);

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
              child: ZegoUIKitPrebuiltLiveStreaming(
                appID:
                727056335, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
                appSign:
                    '9ea02ec0d3be19a5e45e715292f2c1459b18143051f0947fc3087a1db21d117a', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
                userID: widget.profileId.toString(),
                userName: widget.name,
                liveID: widget.liveID,
                config: widget.isHost
                    ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
                    : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
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
