import 'dart:io' show Platform;

import 'package:demo_videocalling/core/routes.dart';
import 'package:demo_videocalling/features/login/domain/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/blueprints/cloud_firebase_messaging.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../../../core/utils/utils_global.dart';
import '../../../../core/utils/utils_ui.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../../domain/usecases/c_f_login_us.dart';

class BodyScreenLogin extends StatefulWidget {
  const BodyScreenLogin({
    Key key,
  }) : super(key: key);

  @override
  _BodyScreenLoginState createState() => _BodyScreenLoginState();
}

class _BodyScreenLoginState extends State<BodyScreenLogin> {
  final controller = TextEditingController();
  String tokenDevice = '';

  @override
  void initState() {
    super.initState();
    checkPermissionsIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Input your name',
            ),
          ),
        ),
        Space(0.05),
        FlatButton(
          onPressed: onPressed,
          child: Text(
            'Enter',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
        ),
      ],
    );
  }

  void onPressed() async {
    final name = controller?.text ?? '';

    if (name.length < 3) {
      UtilsUi.showSnackBarGet('Your name should be at least 4 characters long');
      return;
    }

    final prefs = MyShPrefs();
    final caseLogin = CFLoginUseCase();

    // 1. Save the data in shared prefs
    String id = UtilsGloabals.generateId('user');
    prefs.name = name;
    prefs.id = id;
    
    if (tokenDevice.isEmpty) {
      UtilsUi.showSnackBarGet('Try again or restart the app',
          title: 'Token Device is empty');
      return;
    }

    final result = await caseLogin
        .addUserLocal(UserLocalModel(id: id, token: tokenDevice, name: name));

    if (!result) {
      UtilsUi.showSnackBarGet('Something went wrong');
      return;
    }

    // 2. Pass to the next page
    Get.toNamed(Routes.dashboard);
  }

  void checkPermissionsIfNeeded() {
    if (Platform.isIOS) {
      cloudMessaging.requestPermissionNotification();
    }

    cloudMessaging.getTokenDevice().then((token) {
      print('Token: $token');
      if (token.isNotEmpty) tokenDevice = token;
    });
  }
}
