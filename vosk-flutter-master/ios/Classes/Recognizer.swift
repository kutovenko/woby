//
//  Recognizer.swift
//  vosk_flutter_plugin
//
//  Created by Sidney Douw on 01.06.22.
//

import Foundation
import AVFoundation

public final class Recognizer {
    var recognizer : OpaquePointer!

    init(model: VoskModel, sampleRate: Float) {
        recognizer = vosk_recognizer_new(model.model, sampleRate)
    }
    
    init(model: VoskModel, sampleRate: Float, grammar: String){
        vosk_recognizer_new_grm(model.model, sampleRate, grammar)
    }
    
    deinit {
        vosk_recognizer_free(recognizer);
    }
    
    func recognizeData(buffer : AVAudioPCMBuffer) -> (String, Bool) {
        let dataLen = Int(buffer.frameLength * 2)
        let channels = UnsafeBufferPointer(start: buffer.int16ChannelData, count: 1)
        let endOfSpeech = channels[0].withMemoryRebound(to: Int8.self, capacity: dataLen) {
            vosk_recognizer_accept_waveform(recognizer, $0, Int32(dataLen))
        }
        
        let res = endOfSpeech == 1 ? vosk_recognizer_result(recognizer) : vosk_recognizer_partial_result(recognizer)
        return (String(validatingUTF8: res!)!, endOfSpeech == 1 ? true : false)
    }
    
    func recognizeDataFinal(buffer : AVAudioPCMBuffer) -> String {
        let res = vosk_recognizer_final_result(recognizer)
        return String(validatingUTF8: res!)!
    }
}
