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
        
    }
    
    func shiftPreviousTrack() {
        
    }
    
    func shiftNextTrack() {
        
    }
    
    func stop() {
        
    }
    
    var currentTrack: TrackInfo? {
        get {
            let getMusicInfoScript = """
if application \"Spotify\" is running then
  tell application \"Spotify\"
    if player state is playing then
      set nameValue to (name of current track)
      set artistValue to (artist of current track)
      set albumValue to (album of current track)
      set artworkUrlValue to (artwork url of current track)
      return \"{\\"name\\":\\"\" & nameValue & \"\\",\\"artist\\":\\"\" & artistValue & \"\\",\\"album\\":\\"\" & albumValue & \"\\",\\"artworkUrl\\":\\"\" & artworkUrlValue & \"\\",\\"error\\":\\"\\"}\"
    else
      return \"{\\"name\\":\\"\\",\\"artist\\":\\"\\",\\"album\\":\\"\\",\\"artworkUrl\\":\\"\\",\\"error\\":\\"Don't play music ...\\"}\"
    end if
  end tell
else
  return \"{\\"name\\":\\"\\",\\"artist\\":\\"\\",\\"album\\":\\"\\",\\"artworkUrl\\":\\"\\",\\"error\\":\\"Not open Spotify app ...\\"}\"
end if
"""
            let resDescriptor = self.scriptService.funcToSctipt(getMusicInfoScript)
            guard let resString = resDescriptor.stringValue else { return nil }
            let jsonData = resString.data(using: .utf8)
            guard let jsonObj = try? JSONDecoder().decode(TrackInfo.self, from: jsonData!) else {
                 return nil
            }
            
            return jsonObj
        }
    }
}
