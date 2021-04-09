import 'package:demo_videocalling/features/agora/presentation/getx/video_call_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class VideoCallsTwoViewsCustom extends StatelessWidget {
  const VideoCallsTwoViewsCustom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallingController>(builder: (c) {
      final views = c.views;

      Widget currentUser = views[0];
      Widget guestUser = views[1];

      if (!c.defaultView) {
        currentUser = views[1];
        guestUser = views[0];
      }

      return Stack(
        children: [
          _FullScreenUser(user: guestUser),
          _MiniScreenUser(user: currentUser),
        ],
      );
    });
  }
}

/// This class is inside of a stack
class _FullScreenUser extends StatelessWidget {
  const _FullScreenUser({Key key, @required this.user}) : super(key: key);
  final Widget user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: user,
    );
  }
}

class _MiniScreenUser extends StatelessWidget {
  const _MiniScreenUser({Key key, @required this.user}) : super(key: key);
  final Widget user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 30,
      child: Container(
        width: 120,
        height: 200,
        child: user,
      ),
    );
  }
}
