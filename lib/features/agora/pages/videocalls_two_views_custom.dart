import 'package:flutter/material.dart';

class VideoCallsTwoViewsCustom extends StatelessWidget {
  const VideoCallsTwoViewsCustom(
      {Key key, @required this.views, this.showDefaultView = true})
      : assert(views.length == 2),
        super(key: key);

  final List<Widget> views;

  /// If
  final bool showDefaultView;

  @override
  Widget build(BuildContext context) {
    Widget currentUser = views[0];
    Widget guestUser = views[1];

    if (!showDefaultView) {
      currentUser = views[1];
      guestUser = views[0];
    }

    return Stack(
      children: [
        _FullScreenUser(user: guestUser),
        _MiniScreenUser(user: currentUser),
      ],
    );
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
