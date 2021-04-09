import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:meta/meta.dart';

class VideoCallingModel {
  const VideoCallingModel({
    @required this.channelName,
    @required this.token,
    this.role = ClientRole.Broadcaster,
  });

  ///Necessary to start the call
  final String channelName, token;
  final ClientRole role;
}
