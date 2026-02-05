import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/route/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // navigatorKey: AppRoute.navigatorKey,
      initialRoute: AppRoutes.getInitialRoute(),
      getPages: AppPages.pages,
    );
  }
}
