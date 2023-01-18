import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class VoskFlutterPlugin {
  static const MethodChannel _channel = MethodChannel('vosk_flutter_plugin');
  static const EventChannel _resultMessageChannel = EventChannel('RESULT_EVENT');
  static const EventChannel _partialMessageChannel = EventChannel('PARTIAL_RESULT_EVENT');
  static const EventChannel _finalResultMessageChannel = EventChannel('FINAL_RESULT_EVENT');
  static bool _isLoaded = false;

  static Future<void> initModel(ByteData modelZip) async {
    String modelPath = await _decompressModelBackground(modelZip);
    String result = await _channel.invokeMethod('initModel', modelPath);
    log(result, name: 'INIT VOSK MODEL');
    _isLoaded = true;
  }

  static Future<void> initModelWithGrammar(ByteData modelZip, String grammar) async {
    String modelPath = await _decompressModelBackground(modelZip);
    String result = await _channel.invokeMethod('initModelWithGrammar', {
      'modelPath': modelPath,
      'grammar': grammar,
    });
    log(result, name: 'INIT VOSK MODEL WITH GRAMMAR');
    _isLoaded = true;
  }

  static Future<void> start() async {
    if (_isLoaded) {
      String result = await _channel.invokeMethod('start');
      log(result, name: 'START VOSK RECOGNITION');
    } else {
      log('NO MODEL LOADED', name: 'START VOSK RECOGNITION');
    }
  }

  static Future<void> stop() async {
    if (_isLoaded) {
      String result = await _channel.invokeMethod('stop');
      log(result, name: 'STOP VOSK RECOGNITION');
    } else {
      log('NO MODEL LOADED', name: 'STOP VOSK RECOGNITION');
    }
  }

  static Future<void> setMaxAlternatives(int numAlternatives) async {
    if (_isLoaded) {
      String result = await _channel.invokeMethod('setMaxAlternatives', numAlternatives);
      log(result, name: 'VOSK RECOGNIZER SET MAX ALTERNATIVES');
    } else {
      log('NO MODEL LOADED', name: 'CANCEL VOSK SET MAX ALTERNATIVES');
    }
  }

  static Future<void> setWords(bool words) async {
    if (_isLoaded) {
      String result = await _channel.invokeMethod('setWords', words);
      log(result, name: 'VOSK RECOGNIZER SET WORDS');
    } else {
      log('NO MODEL LOADED', name: 'CANCEL VOSK SET WORDS');
    }
  }

  static Future<void> setPartialWords(bool partialWords) async {
    if (_isLoaded) {
      String result = await _channel.invokeMethod('setPartialWords', partialWords);
      log(result, name: 'VOSK RECOGNIZER SET PARTIAL WORDS');
    } else {
      log('NO MODEL LOADED', name: 'CANCEL VOSK SET PARTIAL WORDS');
    }
  }

  static Stream onResult() {
    return _resultMessageChannel.receiveBroadcastStream();
  }

  static Stream onPartial() {
    return _partialMessageChannel.receiveBroadcastStream();
  }

  static Stream onFinalResult() {
    return _finalResultMessageChannel.receiveBroadcastStream();
  }

  static Future<String> _decompressModelBackground(ByteData zipModelFile) async {
    final p = ReceivePort();
    var decompressedModelPathOut = (await getApplicationDocumentsDirectory()).path;
    await Isolate.spawn(_decompressModel, Args(p.sendPort, zipModelFile, decompressedModelPathOut));
    return await p.first as String;
  }

  static Future<String> _decompressModel(Args args) async {
    // Decode the Zip file
    final archive = ZipDecoder().decodeBytes(args.zipModelFile.buffer.asUint8List());

    var decompressedModelPathOut = '${args.decompressedModelPathOut}/models';

    // Extract the contents of the Zip archive to disk.
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File('$decompressedModelPathOut/$filename')
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        log('$decompressedModelPathOut/$filename', name: 'EN EL ZIP');
        Directory('$decompressedModelPathOut/$filename').create(recursive: true);
      }
    }
    String rootDirectory = '$decompressedModelPathOut/${archive.first.name.replaceAll(RegExp(r'/'), '')}';
    log(rootDirectory, name: 'MODEL DIRECTORY');
    Isolate.exit(args.sendPort, rootDirectory);
  }
}

class Args {
  final SendPort sendPort;
  final ByteData zipModelFile;
  final String decompressedModelPathOut;

  Args(this.sendPort, this.zipModelFile, this.decompressedModelPathOut);
}
