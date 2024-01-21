//
//  SoundPlayer.swift
//  Secronome
//
//  Created by 木村文彬 on 2023/02/12.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    let tickSoundData = NSDataAsset(name: "S04_Ka")!.data
    let tackSoundData = NSDataAsset(name: "B32_Pachi")!.data
    let midSoundData = NSDataAsset(name: "B07_Casha")!.data
    
    var tickSoundPlayer: AVAudioPlayer!
    var tackSoundPlayer: AVAudioPlayer!
    var midSoundPlayer: AVAudioPlayer!
    
    func tickSoundPlay() {
        do {
            tickSoundPlayer = try AVAudioPlayer(data: tickSoundData)
            tickSoundPlayer.play()
        } catch {
            print("tickSound error occured!")
        }
    }
    func tackSoundPlay() {
        do {
            tackSoundPlayer = try AVAudioPlayer(data: tackSoundData)
            tackSoundPlayer.play()
        } catch {
            print("tackSound error occured!")
        }
    }
    func midSoundPlay() {
        do {
            midSoundPlayer = try AVAudioPlayer(data: midSoundData)
            midSoundPlayer.play()
        } catch {
            print("tackSound error occured!")
        }
    }
}
