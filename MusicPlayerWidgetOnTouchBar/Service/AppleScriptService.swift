//
//  AppleScriptService.swift
//  MusicPlayerWidgetOnTouchBar
//
//  Created by Ryota Sekiya on 2019/08/01.
//  Copyright © 2019 sekiya9311. All rights reserved.
//

import Foundation

class AppleScriptService {
    
    @discardableResult
    func funcToSctipt(_ script: String) throws -> NSAppleEventDescriptor {
        
        var error: NSDictionary? = nil
        let scriptObj = NSAppleScript(source: script)!
        let output = scriptObj.executeAndReturnError(&error)
        if error != nil {
            throw NSError(domain: error?.description ?? "", code: -1, userInfo: nil)
        }
        
        return output
    }
}
