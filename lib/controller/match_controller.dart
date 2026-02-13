import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:voicly/model/caller_model.dart';

class MatchController extends GetxController {
  final List<CallerModel> allCandidates;

  // Reactive variables
  var currentDisplayUser = Rxn<CallerModel>();
  var isCycling = true.obs;

  MatchController(this.allCandidates);

  @override
  void onInit() {
    super.onInit();
    _startMatchingProcess();
  }

  void _startMatchingProcess() {
    int iterations = 0;
    const int maxIterations = 25;

    // Filter online users for the final selection
    List<CallerModel> onlineUsers = allCandidates
        .where((u) => u.isOnline == true)
        .toList();
    if (onlineUsers.isEmpty) onlineUsers = allCandidates; // Fallback

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // Shuffling phase
      currentDisplayUser.value =
          allCandidates[Random().nextInt(allCandidates.length)];
      iterations++;

      if (iterations >= maxIterations) {
        timer.cancel();
        // Final Selection phase
        currentDisplayUser.value =
            onlineUsers[Random().nextInt(onlineUsers.length)];
        isCycling.value = false;
      }
    });
  }
}
