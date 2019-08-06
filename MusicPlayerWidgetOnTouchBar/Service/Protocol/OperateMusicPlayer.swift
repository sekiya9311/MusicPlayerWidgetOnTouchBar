//
//  OperateMusicPlayer.swift
//  MusicPlayerWidgetOnTouchBar
//
//  Created by Ryota Sekiya on 2019/08/06.
//  Copyright © 2019 sekiya9311. All rights reserved.
//

import Foundation

protocol OperateMusicPlayer {
    var currentTrack: TrackInfo? { get }
    func playOrPause()
    func shiftPreviousTrack()
    func shiftNextTrack()
    func stop()
}
