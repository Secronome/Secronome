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
    let tickSoundData = NSDataAsset(name: "S04_Ka")!.data
    let tackSoundData = NSDataAsset(name: "B32_Pachi")!.data
    //let midSoundData = NSDataAsset(name: "B32_Pachi")!.data
    let midSoundData = NSDataAsset(name: "B07_Casha")!.data
    
    var tickSoundPlayer: AVAudioPlayer!
    var tackSoundPlayer: AVAudioPlayer!
    var midSoundPlayer: AVAudioPlayer!
    
    func tickSoundPlay() {
        WKInterfaceDevice.current().play(.start)
    }
    func tackSoundPlay() {
        WKInterfaceDevice.current().play(.notification)
    }
    func midSoundPlay() {
        WKInterfaceDevice.current().play(.retry)
    }
}
