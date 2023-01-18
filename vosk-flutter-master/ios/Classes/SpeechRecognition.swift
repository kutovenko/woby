//
//  SpeechRecognition.swift
//  vosk_flutter_plugin
//
//  Created by Sidney Douw on 01.06.22.
//

import Foundation
import AVFoundation

public class SpeechRecognition {
    var resultEventChannel: ResultEventChannel
    var partialResultEventChannel: ResultEventChannel
    var finalResultEventChannel: ResultEventChannel

    var audioEngine: AVAudioEngine
    var processingQueue: DispatchQueue
    
    var recognizer: Recognizer?
    var initialized = false
    var stopped = true
    
    init(registrar: FlutterPluginRegistrar) {
        audioEngine = AVAudioEngine()
        processingQueue = DispatchQueue(label: "recognizerQueue")
        
        resultEventChannel = ResultEventChannel(registrar: registrar, channelName: "RESULT_EVENT")
        partialResultEventChannel = ResultEventChannel(registrar: registrar, channelName: "PARTIAL_RESULT_EVENT")
        finalResultEventChannel = ResultEventChannel(registrar: registrar, channelName: "FINAL_RESULT_EVENT")
    }
    
    public func initModel(pathToModel: String) {
        setupRecognizer(model: VoskModel(pathToModel: pathToModel))
        setupAudioEngine()
        
        initialized = true
    }
    
    public func initModelWithGrammar(pathToModel: String, grammar: String) {
        setupRecognizerWithGrammar(model: VoskModel(pathToModel: pathToModel), grammar: grammar)
        setupAudioEngine()
        
        initialized = true
    }
    
    public func start() {
        if (!initialized) {
            print("Not Initialized Yet")
            return
        }
        
        do {
            try audioEngine.start()
            stopped = false
        } catch {
            print("Unable to start AVAudioEngine: \(error.localizedDescription)")
        }
    }
    
    public func stop() {
        if (!initialized) {
            print("Not Initialized Yet")
            return
        }
        
        stopped = true
    }
    
    public func setMaxAlternatives(n: Int32) {
        if (!initialized) {
            print("Not Initialized Yet")
            return
        }
        
        vosk_recognizer_set_max_alternatives(recognizer!.recognizer, n)
    }
    
    public func setWords(flag: Bool) {
        if (!initialized) {
            print("Not Initialized Yet")
            return
        }
            
        vosk_recognizer_set_words(recognizer!.recognizer, flag ? 1 : 0)
    }
    
    public func setPartialWords(flag: Bool) {
        if (!initialized) {
            print("Not Initialized Yet")
            return
        }
            
        vosk_recognizer_set_partial_words(recognizer!.recognizer, flag ? 1 : 0)
    }
    
    func setupRecognizer(model: VoskModel) {
        if (!initialized) {
            let sampleRate = audioEngine.inputNode.inputFormat(forBus: 0).sampleRate
            self.recognizer = Recognizer(model: model, sampleRate: Float(sampleRate))
        }
    }
    
    func setupRecognizerWithGrammar(model: VoskModel, grammar: String) {
        if (!initialized) {
            let sampleRate = audioEngine.inputNode.inputFormat(forBus: 0).sampleRate
            self.recognizer = Recognizer(model: model, sampleRate: Float(sampleRate), grammar: grammar)
        }
    }
    
    func setupAudioEngine() {
        if (!initialized) {
            let sampleRate = audioEngine.inputNode.inputFormat(forBus: 0).sampleRate
            let formatPcm = AVAudioFormat.init(commonFormat: AVAudioCommonFormat.pcmFormatInt16, sampleRate: sampleRate, channels: 1, interleaved: true)
            
            audioEngine.inputNode.installTap(onBus: 0, bufferSize: UInt32(sampleRate / 10), format: formatPcm, block: onAudioProcess)
        }
    }
    
    func onAudioProcess(buffer: AVAudioPCMBuffer, time: AVAudioTime) {
        self.processingQueue.async {
            if (self.stopped) {
                let data = self.recognizer!.recognizeDataFinal(buffer: buffer)
                DispatchQueue.main.async {
                    self.finalResultEventChannel.update(data: data)
                }
                self.audioEngine.stop()
            } else {
                let (data, isEnd) = self.recognizer!.recognizeData(buffer: buffer)
                DispatchQueue.main.async {
                    if (isEnd) {
                        self.resultEventChannel.update(data: data)
                    } else {
                        self.partialResultEventChannel.update(data: data)
                    }
                }
            }
        }
    }

}

class ResultEventChannel: NSObject, FlutterStreamHandler {
    var channel: FlutterEventChannel
    var event: FlutterEventSink?
    var data: String?
    
    init(registrar: FlutterPluginRegistrar, channelName: String) {
        self.channel = FlutterEventChannel(name: channelName, binaryMessenger: registrar.messenger())
        
        super.init()
        
        self.channel.setStreamHandler(self)
    }
    
    public func update(data: String) {
        self.data = data
        self.send()
    }
    
    func send() {
        guard let evt = self.event else {
            return
        }
        evt(self.data)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.event = events
        self.send()
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.event = nil
        return nil
    }
}
