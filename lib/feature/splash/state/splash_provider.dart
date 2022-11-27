import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woby/core/constant/enums.dart';

import 'splash_state.dart';

final splashProvider =
    StateNotifierProvider<SplashNotifier, SplashState>((ref) => SplashNotifier());

class SplashNotifier extends StateNotifier<SplashState> {
  SplashNotifier() : super(const SplashState());

  setUserFlow() async {
    state = state.copyWith(isLoading: true);
    final prefs = await SharedPreferences.getInstance();
    final bool? notFirstStart = prefs.getBool('notFirstStart');

    if (notFirstStart != null && notFirstStart) {
      state = state.copyWith(isLoading: false, splashState: SplashStates.dashboard);
    } else {
      state = state.copyWith(isLoading: false, splashState: SplashStates.download);
    }
  }
}
