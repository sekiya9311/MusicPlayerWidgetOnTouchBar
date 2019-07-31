//
//  AppleScriptService.swift
//  MusicPlayerWidgetOnTouchBar
//
//  Created by Ryota Sekiya on 2019/08/01.
//  Copyright © 2019 sekiya9311. All rights reserved.
//

import Foundation

class AppleScriptService {
    
    func funcToSctipt(_ script: String,
                      _ successFunc: (NSAppleEventDescriptor) -> Void,
                      _ failedFunc: (NSDictionary?, String?) -> Void) {
        
        var error: NSDictionary? = nil
        if let scriptObj = NSAppleScript(source: script) {
            let output = scriptObj.executeAndReturnError(&error)
            if error != nil {
                failedFunc(error, nil)
                return
            }
            
            successFunc(output)
        }
    }
}
