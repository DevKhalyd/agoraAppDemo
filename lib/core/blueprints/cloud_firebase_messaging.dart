import 'package:demo_videocalling/core/utils/utils_global.dart';
import 'package:demo_videocalling/features/agora/domain/entities/video_calling_model.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:demo_videocalling/features/dashboard/presentation/widgets/dashboard_body.dart';

import '../routes.dart';

final cloudMessaging = CloudMessagingUseCase();

class CloudMessagingUseCase {
  // The instance getter is not available in v.7.0.0
  // More info:
  //https://stackoverflow.com/questions/65318728/the-getter-instance-isnt-defined-for-the-type-firebasemessaging
  final _messaging = FirebaseMessaging();

  /// Return `true` if the user  granted permission. Only ios
  Future<bool> requestPermissionNotification() async {
    try {
      final responseUser = await _messaging.requestNotificationPermissions();
      // If the response is false we can show an alert to enable the notifications in IOS
      return responseUser;
    } catch (e) {
      return false;
    }
  }

  Future<String> getTokenDevice() async => await _messaging.getToken();

  // More info: https://stackoverflow.com/questions/52115255/call-onmessage-method-when-the-app-is-in-background-in-flutter
  void setMessageHandler() => _messaging.configure(
        onBackgroundMessage: _onBackgroundMessage,
        onLaunch: _onLaunch,
        onMessage: _onMessage,
        onResume: _onResume,
      );
}

// App state: Background
// ignore: missing_return
Future _onBackgroundMessage(Map<String, dynamic> message) {
  print('onBackgroundMessage $message');
}

// App state:(?)
// ignore: missing_return
Future _onResume(Map<String, dynamic> message) {
  print('_onResume $message');
}

// App state: (?)
// ignore: missing_return
Future _onLaunch(Map<String, dynamic> message) {
  print('_onLaunch $message');
}

// App state: Foreground
Future _onMessage(Map<String, dynamic> message) async {
  print('onMessage $message');

  final useMAP = message['data'];

  final resultMap = TempResponse(
    token: useMAP['token'],
    channelName: useMAP['channel'],
  );

  await UtilsGloabals.askForPermissions();

  Get.toNamed(Routes.videocalling,
      arguments: VideoCallingModel(
        channelName: resultMap.channelName,
        token: resultMap.token,
      ));
}
