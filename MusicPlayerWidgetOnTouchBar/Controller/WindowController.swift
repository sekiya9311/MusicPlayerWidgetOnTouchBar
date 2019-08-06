//
//  WindowController.swift
//  MusicPlayerWidgetOnTouchBar
//
//  Created by Ryota Sekiya on 2019/07/29.
//  Copyright © 2019 sekiya9311. All rights reserved.
//

import Cocoa

protocol WindowProtocol {
    var artWork: NSImage? { get set }
    var musicDetail: String? { get set }
}

class WindowController: NSWindowController {
    
    private lazy var presenter = WindowPresenter(
        self,
        operateMusicPlayerService: OperateSpotify(AppleScriptService()))
    
    @IBAction func prevAction(_ sender: Any) {
        presenter.shiftPrevMusic()
    }
    
    @IBAction func playPauseAction(_ sender: Any) {
        presenter.playOrPauseMusic()
    }
    
    @IBAction func stopAction(_ sender: Any) {
        presenter.stopMusic()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        presenter.shiftNextMusic()
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        presenter.createDisplayData()
    }
    
    override func close() {
        presenter.dispose()
    }
    
    @IBOutlet weak var currentMusicDetail: NSTextField!
    @IBOutlet weak var currentMusicArtwork: NSImageCell!
}

extension WindowController: WindowProtocol {
    var artWork: NSImage? {
        get {
            return currentMusicArtwork?.image
        }
        set {
            currentMusicArtwork?.image = newValue
        }
    }
    var musicDetail: String? {
        get {
            return currentMusicDetail?.stringValue
        }
        set {
            currentMusicDetail?.stringValue = newValue ?? ""
        }
    }
}
