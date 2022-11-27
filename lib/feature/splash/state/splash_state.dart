import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:woby/core/constant/enums.dart';
part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(SplashStates.download) SplashStates splashState,
    @Default(false) isLoading,
  }) = _SplashState;

  const SplashState._();
}
