import 'package:get/get.dart';
import 'package:voicly/networks/auth_services.dart';
import 'package:voicly/networks/user_service.dart';

class ServiceLocator {
  static Future<void> init() async {
    // Register Repository First
    Get.put(UserRepository(), permanent: true);

    // Register AuthService and wait for its internal init()
    await Get.putAsync(() => AuthService().init(), permanent: true);
  }
}
