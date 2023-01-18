import Flutter
import UIKit

public class SwiftVoskFlutterPlugin: NSObject, FlutterPlugin {
    
  var speechRecognition: SpeechRecognition?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SwiftVoskFlutterPlugin()
      
    let channel = FlutterMethodChannel(name: "vosk_flutter_plugin", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)
      
    instance.speechRecognition = SpeechRecognition(registrar: registrar)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case "initModel":
          if let args = call.arguments as? String {
              speechRecognition?.initModel(pathToModel: args)
              result("OK")
          } else {
              result("FAILED")
          }
          break
    
      case "initModelWithGrammar":
          if let args = call.arguments as? [String: String],
             let pathToModel = args["modelPath"],
             let grammar = args["grammar"] {
              speechRecognition?.initModelWithGrammar(pathToModel: pathToModel, grammar: grammar)
              result("OK")
          } else {
              result("FAILED")
          }
          break
          
      case "start":
          speechRecognition?.start()
          result("OK")
          break
          
      case "stop":
          speechRecognition?.stop()
          result("OK")
          break
          
      case "setMaxAlternatives":
          speechRecognition?.setMaxAlternatives(n: call.arguments as? Int32 ?? 1)
          result("OK")
          break
          
      case "setWords":
          speechRecognition?.setWords(flag: call.arguments as? Bool ?? false)
          result("OK")
          break
          
      case "setPartialWords":
          speechRecognition?.setPartialWords(flag: call.arguments as? Bool ?? false)
          result("OK")
          break
          
      default:
          result(FlutterMethodNotImplemented)
      }
  }
}
