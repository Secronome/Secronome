//
//  SoundPlayer.swift
//  Watch Secronome Watch App
//
//  Created by 木村文彬 on 2023/10/22.
//

import UIKit
import AVFoundation
import WatchKit

class SoundPlayer: NSObject {
    var tickSoundPlayer: AVAudioPlayer!
    var tackSoundPlayer: AVAudioPlayer!
    var midSoundPlayer: AVAudioPlayer!
    
    func tickSoundPlay() {
        WKInterfaceDevice.current().play(.start)
    }
    func tackSoundPlay() {
        WKInterfaceDevice.current().play(.success)
    }
    func midSoundPlay() {
        WKInterfaceDevice.current().play(.retry)
    }
}
