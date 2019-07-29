//
//  WindowController.swift
//  MusicPlayerWidgetOnTouchBar
//
//  Created by Ryota Sekiya on 2019/07/29.
//  Copyright © 2019 sekiya9311. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBAction func prevAction(_ sender: Any) {
    }
    
    @IBAction func playPauseAction(_ sender: Any) {
    }
    
    @IBAction func stopAction(_ sender: Any) {
    }
    
    @IBAction func nextAction(_ sender: Any) {
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @IBOutlet weak var currentMusicDetail: NSTextField!
    @IBOutlet weak var currentMusicArtwork: NSImageCell!
}
