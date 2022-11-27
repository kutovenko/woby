import 'package:get_it/get_it.dart';

import 'network/dio_provider.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<DioProvider>(() => DioProvider()..configureDio());
}
