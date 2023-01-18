//
//  VoskModel.swift
//  vosk_flutter_plugin
//
//  Created by Sidney Douw on 01.06.22.
//

import Foundation

public final class VoskModel {
    
    var model : OpaquePointer!
    
    init(pathToModel: String) {
        vosk_set_log_level(-1);
        model = vosk_model_new(pathToModel)
    }
    
    deinit {
        vosk_model_free(model)
    }
    
}
