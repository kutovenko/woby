import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woby/core/constant/app_constants.dart';

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:woby/core/locator.dart';
import 'package:woby/core/network/dio_provider.dart';

import 'download_state.dart';

final downloadProvider =
    StateNotifierProvider<DownloadNotifier, DownloadState>((ref) => DownloadNotifier());

class DownloadNotifier extends StateNotifier<DownloadState> {
  DownloadNotifier() : super(const DownloadState());

  final dio = locator.get<DioProvider>().dio;

  Future downloadLangModel() async {
    state = state.copyWith(isLoading: true, isError: false);
    try {
      Response response = await dio.get(
        AppConstants.engModelUrl,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status != null && status == 200;
            }),
      );
      print(response.headers);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = '${appDocDir.path}/english.zip';
      File file = File(appDocPath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('model_downloaded', true);
      state = state.copyWith(isCompleted: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, isError: true);
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      state = state.copyWith(percentCompleted: (received / total));
    }
  }
}
