import 'package:demo_videocalling/core/utils/utils_ui.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class UtilsGloabals {
  static String generateId(String prefix) =>
      '${prefix}_${DateTime.now().millisecondsSinceEpoch.toString()}';

  static Future<void> askForPermissions() async {
    await handleCameraAndMic(Permission.camera);
    await handleCameraAndMic(Permission.microphone);
  }
}
