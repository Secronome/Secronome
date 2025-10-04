// View of secronome

import SwiftUI
import WatchKit

struct ContentView: View {
    @State var timerHandler: Timer?
    @State var tickCount = 0
    @AppStorage("tack_Count") var tackCount = 6
    @AppStorage("mid_Flg") var midFlg = true
    @State var showAlert = false
    @State var progressValue: CGFloat = 1.0
    @State var switchFlg = true // Start & Stop button flag
    
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        ZStack {
            Color("backgroundTick")
                .ignoresSafeArea()
            
            VStack {
                // Display Large Progress Circle
                CircularProgressView(progress: $progressValue)
                Spacer()
                // Play & Reset button
                HStack(spacing: 2.0) {
                    // Left button
                    Button {
                        StartTickTack()
                    } label: {
                        if switchFlg {
                            Text("▶︎")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 50, height: 50)
                                .background(Color("startButtonColor"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            Text("■")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 50, height: 50)
                                .background(Color("stopButtonColor"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    // Right button
                    Button {
                        // Reset time
                        tickCount = 0
                        progressValue = 1.0
                        // feed back
                        WKInterfaceDevice.current().play(.stop)
                    } label: {
                        Text("R")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .frame(width: 50, height: 50)
                            .background(Color("resetButtonColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .onAppear {
            tickCount = 0
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
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 15))
                .scaledToFit()
                .frame(width: 80, height: 80)
                .opacity(0.3)
                .padding(8)
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .scaledToFit()
                .padding(8)
                .rotationEffect(Angle(degrees: -90.0))
            
        }
    }
}

#Preview {
    ContentView()
}
