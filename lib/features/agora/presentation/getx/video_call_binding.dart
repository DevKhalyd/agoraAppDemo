import 'package:get/get.dart';

import 'video_call_controller.dart';

class VideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VideoCallingController());
  }
}
