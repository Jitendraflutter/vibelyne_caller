// import 'package:flutter/material.dart';
//
// enum TransitionType { slideBottom, slideRight, fade, scale }
//
// class AppRoute {
//   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
//   static Future<T?> push<T>(Widget page, {TransitionType transition = TransitionType.slideRight}) {
//     return navigatorKey.currentState!.push<T>(
//       _createRoute(page, transition),
//     );
//   }
//
//   // 3. Push and Replace
//   static Future<T?> pushReplacement<T, TO>(Widget page, {TransitionType transition = TransitionType.fade}) {
//     return navigatorKey.currentState!.pushReplacement<T, TO>(
//       _createRoute(page, transition),
//     );
//   }
//
//
//   static Future<T?> pushAndRemoveAll<T>(
//       Widget page, {
//         TransitionType transition = TransitionType.fade,
//       }) {
//     return navigatorKey.currentState!.pushAndRemoveUntil<T>(
//       _createRoute(page, transition),
//           (route) => false, // removes all previous routes
//     );
//   }
//
//
//   // 4. Pop
//   static void pop<T>([T? result]) {
//     return navigatorKey.currentState!.pop<T>(result);
//   }
//
//   // 5. Internal Route Builder
//   static Route<T> _createRoute<T>(Widget page, TransitionType type) {
//     return PageRouteBuilder<T>(
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         switch (type) {
//           case TransitionType.slideRight:
//             return SlideTransition(
//               position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
//               child: child,
//             );
//           case TransitionType.slideBottom:
//             return SlideTransition(
//               position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
//               child: child,
//             );
//           case TransitionType.fade:
//             return FadeTransition(opacity: animation, child: child);
//           case TransitionType.scale:
//             return ScaleTransition(scale: animation, child: child);
//           }
//       },
//       transitionDuration: const Duration(milliseconds: 300),
//     );
//   }
// }
