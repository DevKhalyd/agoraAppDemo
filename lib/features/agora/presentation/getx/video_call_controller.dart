import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:demo_videocalling/features/agora/domain/entities/video_calling_model.dart';
import 'package:demo_videocalling/features/agora/utils/settings.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoCallingController extends GetxController {
  static VideoCallingController get to => Get.find();

  final users = <int>[];
  final infoStrings = <String>[];
  var views = <Widget>[];

  VideoCallingModel videoCallingModel;
  bool muted = false, defaultView = true;
  RtcEngine engine;

  @override
  void onInit() {
    initController();
    super.onInit();
  }

  @override
  void onReady() {
    assignViews();
    super.onReady();
  }

  @override
  void onClose() {
    views = [];
    // clear users
    users.clear();
    // destroy sdk
    engine.leaveChannel();
    engine.destroy();
    super.onClose();
  }

  Future<void> initController() async {
    final data = Get.arguments as VideoCallingModel;
    if (data is! VideoCallingModel) {
      assert(false, 'Missing VideoCallingModel');
      return;
    }
    videoCallingModel = data;
    await _initAgoraRtcEngine();
  }

  void assignViews() {
    views = _getRenderViews();
    update();
  }

  void _agoraEventHandlers() {
    engine.setEventHandler(RtcEngineEventHandler(
        error: (code) {
          print('Something bad happens');
        },
        joinChannelSuccess: (channel, uid, elapsed) {
          print('onJoinChannel: $channel, uid: $uid');
        },
        leaveChannel: (stats) {
          users.clear();
          assignViews();
        },
        userJoined: (uid, elapsed) {
          users.add(uid);
          assignViews();
        },
        userOffline: (uid, elapsed) {
          users.remove(uid);
          assignViews();
        },
        firstRemoteVideoFrame: (uid, width, height, elapsed) {}));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (videoCallingModel.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  void onToggleMute() {
    muted = !muted;
    engine?.muteLocalAudioStream(muted);
    update();
  }

  void onSwitchCamera() => engine.switchCamera();

  /// Get the camera from the back to the fronted
  void onChangeViews() {
    defaultView = !defaultView;
    update();
  }

  // That method is for configure the engine and the screen. Please don't modify

  Future<void> _initAgoraRtcEngine() async {
    // ignore: deprecated_member_use
    engine = await RtcEngine.create(Settings.APP_ID);
    await engine.enableVideo();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine.setClientRole(videoCallingModel.role);

    _agoraEventHandlers();

    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(1920, 1080);
    await engine.setVideoEncoderConfiguration(configuration);
    await engine.joinChannel(
      videoCallingModel.token,
      videoCallingModel.channelName,
      null,
      0,
    );
  }
}
