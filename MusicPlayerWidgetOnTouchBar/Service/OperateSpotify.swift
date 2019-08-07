//
//  OperateSpotify.swift
//  MusicPlayerWidgetOnTouchBar
//
//  Created by Ryota Sekiya on 2019/08/06.
//  Copyright © 2019 sekiya9311. All rights reserved.
//

import Foundation

class OperateSpotify: OperateMusicPlayer {
    
    private let scriptService: AppleScriptService
    
    init(_ scriptService: AppleScriptService) {
        self.scriptService = scriptService
    }
    
    func playOrPause() {
        let script = """
if application \"Spotify\" is running then
  tell application \"Spotify\"
    playpause
  end tell
end if
"""
        
        try! scriptService.funcToSctipt(script)
    }
    
    func shiftPreviousTrack() {
        let script = """
if application \"Spotify\" is running then
  tell application \"Spotify\"
    previous track
  end tell
end if
"""
        
        try! scriptService.funcToSctipt(script)
    }
    
    func shiftNextTrack() {
        let script = """
if application \"Spotify\" is running then
  tell application \"Spotify\"
    next track
  end tell
end if
"""
        try! scriptService.funcToSctipt(script)
    }
    
    func stop() {
        let script = """
if application \"Spotify\" is running then
  tell application \"Spotify\"
    pause
  end tell
end if
"""
        
        try! scriptService.funcToSctipt(script)
    }
    
    var appName: String = "Spotify"
    
    var runningApp: Bool {
        get {
            let script = "return application \"Spotify\" is running"
            
            let resDescriptor = try? scriptService.funcToSctipt(script)
            return resDescriptor?.booleanValue ?? false
        }
    }
    
    var currentTrack: TrackInfo? {
        get {
            let getMusicInfoScript = """
if application \"Spotify\" is running then
  tell application \"Spotify\"
    set nameValue to (name of current track)
    set artistValue to (artist of current track)
    set albumValue to (album of current track)
    set artworkUrlValue to (artwork url of current track)
    return \"{\\"name\\":\\"\" & nameValue & \"\\",\\"artist\\":\\"\" & artistValue & \"\\",\\"album\\":\\"\" & albumValue & \"\\",\\"artworkUrl\\":\\"\" & artworkUrlValue & \"\\",\\"error\\":\\"\\"}\"
  end tell
else
  return \"{\\"name\\":\\"\\",\\"artist\\":\\"\\",\\"album\\":\\"\\",\\"artworkUrl\\":\\"\\",\\"error\\":\\"Not open Spotify app ...\\"}\"
end if
"""
            guard let resDescriptor = try? self.scriptService.funcToSctipt(getMusicInfoScript) else { return nil }
            guard let resString = resDescriptor.stringValue else { return nil }
            let jsonData = resString.data(using: .utf8)
            guard let jsonObj = try? JSONDecoder().decode(TrackInfo.self, from: jsonData!) else {
                 return nil
            }
            
            return jsonObj
        }
    }
}
