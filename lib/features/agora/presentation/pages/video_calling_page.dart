import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages_default_view/videocalls_two_views_custom.dart';
import '../getx/video_call_controller.dart';
import 'package:flutter/services.dart';

/// This page needs a [VideoCallingModel] as a param from the `Get.arguments`
class VideoCallingPage extends StatelessWidget {
  const VideoCallingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallingController>(
      init: VideoCallingController(),
      builder: (c) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: <Widget>[
                  VideoCallScreens(),
                  _BackButton(),
                  _VideoCallActions(),
                  _SwitchCameraViews(),
                  //Options
                ],
              ),
            ));
      },
    );
  }
}

class _SwitchCameraViews extends StatelessWidget {
  const _SwitchCameraViews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 56,
        right: 16,
        child: GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.flip_camera_android_outlined,
              color: Colors.white,
            )));
  }

  void onTap() => VideoCallingController.to.onChangeViews();
}

class VideoCallScreens extends StatelessWidget {
  const VideoCallScreens({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallingController>(
      builder: (c) {
        final views = c.views;
        
        switch (views.length) {
          case 1:
            return Container(
              child: Center(
                child: Text('Waiting for another user...',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            );
          case 2:
            return VideoCallsTwoViewsCustom();
          default:
            return Container(
                color: Colors.black,
                child: Center(
                  child: Text('Porfavor revise su conexión a Internet',
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ));
        }
      },
    );
  }
}

class _VideoCallActions extends StatelessWidget {
  const _VideoCallActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallingController>(
      builder: (c) {
        final muted = c.muted;

        if (c.videoCallingModel.role == ClientRole.Audience) return Container();
        return Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                onPressed: VideoCallingController.to.onToggleMute,
                child: Icon(
                  muted ? Icons.mic_off : Icons.mic,
                  color: muted ? Colors.white : Colors.blueAccent,
                  size: 20.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: muted ? Colors.blueAccent : Colors.white,
                padding: const EdgeInsets.all(12.0),
              ),
              RawMaterialButton(
                onPressed: () => Get.back(),
                child: Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.redAccent,
                padding: const EdgeInsets.all(15.0),
              ),
              RawMaterialButton(
                onPressed: VideoCallingController.to.onSwitchCamera,
                child: Icon(
                  Icons.switch_camera,
                  color: Colors.blueAccent,
                  size: 20.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.white,
                padding: const EdgeInsets.all(12.0),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 56,
        left: 16,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ));
  }
}
