//
//  AppDelegate.swift
//  Secronome
//
//  Created by 木村文彬 on 2023/02/22.
//
import UIKit
import AVFoundation

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?
    // Play in background
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
        return true
    }
}
