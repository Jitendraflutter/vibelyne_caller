import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< Updated upstream
=======
import 'package:get_storage/get_storage.dart';
import 'package:voicly/core/utils/notification_service.dart';
import 'package:voicly/core/utils/service_locator.dart';

>>>>>>> Stashed changes
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
<<<<<<< Updated upstream
  // await Firebase.initializeApp();
  // await GetStorage.init();
  // await ServiceLocator.init();
=======
  await Firebase.initializeApp();
  await GetStorage.init();
  setupFlutterNotifications();
  await ServiceLocator.init();
>>>>>>> Stashed changes
  runApp(App());
}
