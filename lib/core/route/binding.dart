import 'package:get/get.dart';
import 'package:voicly/controller/caller_overlay_controller.dart';
import 'package:voicly/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(CallOverlayController(), permanent: true);
  }
}
