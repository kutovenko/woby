import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woby/feature/dashboard/dashboard_screen.dart';
import 'package:woby/feature/download/state/download_provider.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref.watch(downloadProvider).isLoading;
    final double progress = ref.watch(downloadProvider).percentCompleted;
    final bool completed = ref.watch(downloadProvider).completed;

    return isLoading
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    // color: Colors.grey,
                    // valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 6.0,
                    value: progress,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text('${(progress * 100).toStringAsFixed(0)} % completed'),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: completed
                        ? () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const DashboardScreen()),
                            (route) => false)
                        : null,
                    child: Text('continue'.tr()))
              ],
            ),
          )
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('we_need_to_download'.tr()),
                const Text('this_will_take 40 Mb. on your phone'),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () => ref.read(downloadProvider.notifier).downloadLangModel(),
                    child: Text('download'.tr()))
              ],
            ),
          );
  }
}

class DownloadProgressWidget extends StatelessWidget {
  const DownloadProgressWidget(
      {required this.finalAction, required this.total, required this.progress, Key? key})
      : super(key: key);

  final int progress;
  final int total;
  final Function finalAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(
          strokeWidth: 20,
          value: double.parse(progress.toString()),
        ),
      ),
    );
  }
}
