import 'package:freezed_annotation/freezed_annotation.dart';
part 'download_state.freezed.dart';

@freezed
class DownloadState with _$DownloadState {
  const factory DownloadState(
      {@Default(false) bool completed,
      @Default(false) isLoading,
      @Default(0) int total,
      @Default(0.0) double percentCompleted}) = _DownloadState;

  const DownloadState._();
}
