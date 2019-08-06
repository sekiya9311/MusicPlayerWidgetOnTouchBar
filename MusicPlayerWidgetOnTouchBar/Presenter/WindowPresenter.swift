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
    private let operateMusicPlayerService: OperateMusicPlayer
    
    init(_ view: View, operateMusicPlayerService: OperateMusicPlayer) {
        self.view = view
        self.operateMusicPlayerService = operateMusicPlayerService
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
        guard let curTrack = operateMusicPlayerService.currentTrack else {
            view?.musicDetail = "Can't get info ..."
            view?.artWork = nil
            return
        }
        
        if !curTrack.error.isEmpty {
            view?.musicDetail = curTrack.error
            return
        }
        
        var musicDetail = ""
        musicDetail += curTrack.name + ": " + curTrack.artist
        musicDetail += "\n"
        musicDetail += curTrack.album
        view?.musicDetail = musicDetail
        view?.artWork = NSImage(contentsOf: URL(string: curTrack.artworkUrl)!)
    }
}
