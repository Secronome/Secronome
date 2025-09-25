//
//  ExtensionDelegate.swift
//  Secronome
//
//  Created by 木村文彬 on 2025/09/11.
//

import WatchKit
import AVFoundation

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func applicationDidFinishLaunching() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [])
            try session.setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
    }
}
