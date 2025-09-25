//
//  ContentView.swift
//  Secronome
//
//  Created by 木村文彬 on 2023/01/28.
//

import SwiftUI
import AudioToolbox

struct ContentView: View {
    @State var timerHandler: Timer?
    @State var tickCount = 0
    @AppStorage("tack_Count") var tackCount = 6
    @AppStorage("mid_Flg") var midFlg = false
    @State var showAlert = false
    @State var progressValue: CGFloat = 1.0
    @State var switchFlg = true // Start & Stop button flag
    @State var soundIdReset:SystemSoundID = 1103    // TickTack SystemSound
    
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundTick")
                    .ignoresSafeArea()
                
                VStack(spacing: 20.0) {
                    // Display Large Progress Circle
                    CircularProgressView(progress: $progressValue)
                    //.scaledToFit()
                        .padding(24.0)
                    //Spacer()
                    Text ("Tack Count : \(tackCount)")
                        .font(.largeTitle)
                        .bold()
                    Text("Middle Sound : \(midFlg ? "ON" : "OFF")")
                        .font(.largeTitle)
                        .bold()
                    // Start & Reset Button
                    HStack(spacing: 50.0) {
                        // Left button
                        Button {
                            StartTickTack()
                        } label: {
                            if switchFlg {
                                Text("Start")
                                    .font(.title)
                                    .foregroundColor(Color.white)
                                    .frame(width: 100, height: 100)
                                    .background(Color("startButtonColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Text("Stop")
                                    .font(.title)
                                    .foregroundColor(Color.white)
                                    .frame(width: 100, height: 100)
                                    .background(Color("stopButtonColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        // Right button
                        Button {
                            tickCount = 0
                            progressValue = 1.0
                            if let soundUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), nil, nil, nil) {
                                AudioServicesCreateSystemSoundID(soundUrl, &soundIdReset)
                                AudioServicesPlaySystemSound(soundIdReset)
                            }
                            
                        } label: {
                            Text("Reset")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 100, height: 100)
                                .background(Color("resetButtonColor"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                tickCount = 0
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("Setting")
                    }
                }
            }
        }
    }
    // Countdown per second
    func TickTackTimer() {
        // Count up per second
        tickCount += 1
        progressValue = CGFloat(Double(tackCount - tickCount) / Double(tackCount))
        
        if tackCount - tickCount <= 0 {
            // Reset timer when remain time become zero
            tickCount = 0
            soundPlayer.tackSoundPlay()
        } else if tickCount == tackCount / 2 && midFlg {
            soundPlayer.midSoundPlay()
        } else {
            soundPlayer.tickSoundPlay()
        }
    }
    
    // Activate when Start Button Tapped
    func StartTickTack() {
        if switchFlg {
            // Count down if left button is Start
            switchFlg = false
            
            // Don't anything if timer is valid
            if let unwrapedTimerHandler = timerHandler {
                if unwrapedTimerHandler.isValid == true {
                    return
                }
            }
            
            // reset the counter when counter is under the storage's counter
            if tackCount - tickCount <= 0 {
                tickCount = 0
            }
            
            // Start timer
            timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                TickTackTimer()
            }
        } else {
            // Stop count down if left button is Stop
            switchFlg = true
            
            if let unwrapedTimerHandler = timerHandler {
                if unwrapedTimerHandler.isValid == true {
                    unwrapedTimerHandler.invalidate()
                }
            }
        }
    }
}

struct CircularProgressView: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        // Background Circle
        ZStack(alignment: .center) {
            Circle()
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 30))
                .scaledToFit()
                .opacity(0.3)
                .padding(32)
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                .scaledToFit()
                .padding(32)
                .rotationEffect(Angle(degrees: -90.0))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
