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
    private let operateMusicPlayerService: OperateMusicPlayer
    private var timer: Timer?
    
    init(_ view: View, operateMusicPlayerService: OperateMusicPlayer) {
        self.view = view
        self.operateMusicPlayerService = operateMusicPlayerService
        self.timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(WindowPresenter.createDisplayData),
            userInfo: nil,
            repeats: true)
    }
    
    func shiftPrevMusic() {
        operateMusicPlayerService.shiftPreviousTrack()
    }
    
    func playOrPauseMusic() {
        operateMusicPlayerService.playOrPause()
    }
    
    func stopMusic() {
        operateMusicPlayerService.stop()
    }
    
    func shiftNextMusic() {
        operateMusicPlayerService.shiftNextTrack()
    }
    
    @objc func createDisplayData() {
        guard let curTrack = operateMusicPlayerService.currentTrack else {
            view?.musicDetail = "Can't get info ..."
            view?.artWork = nil
            return
        }
        
        if !curTrack.error.isEmpty {
            view?.musicDetail = curTrack.error
            view?.artWork = nil
            return
        }
        
        var musicDetail = ""
        musicDetail += curTrack.name + ": " + curTrack.artist
        musicDetail += "\n"
        musicDetail += curTrack.album
        
        if view?.musicDetail == musicDetail {
            return
        }
        
        view?.musicDetail = musicDetail
        view?.artWork = NSImage(contentsOf: URL(string: curTrack.artworkUrl)!)
    }
    
    func dispose() {
        self.timer?.invalidate()
    }
}
