import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woby/core/constant/app_constants.dart';
import 'package:woby/core/constant/enums.dart';
import 'package:woby/feature/dashboard/dashboard_screen.dart';
import 'package:woby/feature/download/download_screen.dart';
import 'package:woby/feature/splash/state/splash_provider.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends ConsumerState<StartScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(splashProvider.notifier).setUserFlow();
  }

  @override
  Widget build(BuildContext context) {
    final SplashStates mode = ref.watch(splashProvider).splashState;
    final bool isLoading = ref.watch(splashProvider).isLoading;
    print('mode: $mode -- isLoading: $isLoading');

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : mode == SplashStates.download
              ? const DownloadScreen()
              : const DashboardScreen(),
    ));
  }
}
