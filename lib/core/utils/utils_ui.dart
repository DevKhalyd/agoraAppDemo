import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class UtilsUi {
  static void showSnackBarGet(String subtitle, {String title = 'Message'}) =>
      Get.snackbar(title, subtitle);
}

Future<void> handleCameraAndMic(Permission permission) async {
  final status = await permission.request();
  print(status);
}
