import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vosk_flutter_plugin/vosk_flutter_plugin.dart';
import 'package:woby/core/locator.dart';
import 'package:woby/feature/splash/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();

  ByteData modelZip = await rootBundle.load('assets/models/vosk-model-small-en-us-0.15.zip');
  await VoskFlutterPlugin.initModel(modelZip);

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


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:vosk_flutter_plugin/vosk_flutter_plugin.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   bool isModelLoading = false;
//   bool isModelLoaded = false;
//   bool isRecognizing = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Vosk Demo'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: Center(
//           child: Column(
//             children: [
//               if (!isModelLoaded && !isModelLoading)
//                 ElevatedButton(
//                     onPressed: () async {
//                       setState(() {
//                         isModelLoading = true;
//                       });
//                       ByteData modelZip = await rootBundle.load('assets/models/vosk-model-small-en-us-0.15.zip');
//                       await VoskFlutterPlugin.initModel(modelZip);
//                       setState(() {
//                         isModelLoading = false;
//                         isModelLoaded = true;
//                       });
//                     },
//                     child: const Text('Load and init model')),
//               if (isModelLoading) const CircularProgressIndicator(),
//               if (isModelLoaded) const Text('Model loaded'),
//               ElevatedButton(
//                   onPressed: !isRecognizing && isModelLoaded
//                       ? () {
//                     VoskFlutterPlugin.start();
//                     setState(() {
//                       isRecognizing = true;
//                     });
//                   }
//                       : null,
//                   child: const Text('Recognize microphone')),
//               ElevatedButton(
//                   onPressed: isRecognizing
//                       ? () {
//                     VoskFlutterPlugin.stop();
//                     setState(() {
//                       isRecognizing = false;
//                     });
//                   }
//                       : null,
//                   child: const Text('Stop recognition')),
//               const SizedBox(height: 20),
//               const Text('On Partial'),
//               StreamBuilder(
//                 stream: VoskFlutterPlugin.onPartial(),
//                 builder: (context, snapshot) => Text(snapshot.data.toString()),
//               ),
//               const SizedBox(height: 20),
//               const Text('On Result'),
//               StreamBuilder(
//                 stream: VoskFlutterPlugin.onResult(),
//                 builder: (context, snapshot) => Text(snapshot.data.toString()),
//               ),
//               const SizedBox(height: 20),
//               const Text('On final result'),
//               StreamBuilder(
//                 stream: VoskFlutterPlugin.onFinalResult(),
//                 builder: (context, snapshot) => Text(snapshot.data.toString()),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:vosk_flutter_plugin/vosk_flutter_plugin.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future<void> initModel() async {
//     ByteData modelZip = await rootBundle.load('assets/models/vosk-model-small-en-us-0.15.zip');
//     await VoskFlutterPlugin.initModel(modelZip);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Home(),
//     );
//   }
// }
