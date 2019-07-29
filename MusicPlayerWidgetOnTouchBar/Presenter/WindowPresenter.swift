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
        
    }
}
