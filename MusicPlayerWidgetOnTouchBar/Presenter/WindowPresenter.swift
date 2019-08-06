//
//  WindowPresenter.swift
//  MusicPlayerWidgetOnTouchBar
//
//  Created by Ryota Sekiya on 2019/07/29.
//  Copyright © 2019 sekiya9311. All rights reserved.
//

import Cocoa
import Foundation

final class WindowPresenter {
    typealias View = NSWindowController & WindowProtocol
    
    private weak var view: View?
    private var scriptService = AppleScriptService()
    
    init(_ view: View) {
        self.view = view
    }
    
    func shiftPrevMusic() {
        // TODO: impl
        createDisplayData()
    }
    
    func playOrPauseMusic() {
        // TODO: impl
        createDisplayData()
    }
    
    func stopMusic() {
        // TODO: impl
        createDisplayData()
    }
    
    func shiftNextMusic() {
        // TODO: impl
        createDisplayData()
    }
    
    private func createDisplayData() {
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
        
        scriptService.funcToSctipt(
            getMusicInfoScript,
            { (output) -> Void in
                
                let getInfo = { () -> Bool in
                    guard let res = output.stringValue else { return false }
                    let jsonData = res.data(using: .utf8)
                    guard let obj = try? JSONDecoder().decode(TrackInfo.self, from: jsonData!) else {
                        return false
                    }
                    if !obj.error.isEmpty {
                        // catch error
                        self.view?.musicDetail = obj.error
                        return true
                    }
                    
                    var musicDetail = ""
                    musicDetail += obj.name + ": " + obj.artist
                    musicDetail += "\n"
                    musicDetail += obj.album
                    
                    self.view?.musicDetail = musicDetail
                    self.view?.artWork = NSImage(contentsOf: URL(string: obj.artworkUrl)!)
                    
                    return true
                }
                
                if (!getInfo()) {
                    view?.musicDetail = "Can't get info ..."
                }
                
            },
            { (error, errorStr) -> Void in
                view?.musicDetail = "Can't get info ..."
            }
        )
    }
}
