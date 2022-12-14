import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woby/core/locator.dart';
import 'package:woby/feature/splash/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      fallbackLocale: const Locale('en', 'US'),
      child: const ProviderScope(child: WobyApp())));
}

class WobyApp extends StatelessWidget {
  const WobyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const StartScreen(),
    );
  }
}
