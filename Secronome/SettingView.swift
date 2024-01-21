//
//  SettingView.swift
//  Secronome
//
//  Created by 木村文彬 on 2023/01/28.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("tack_Count") var tackCount = 6
    @AppStorage("mid_Flg") var midFlg = false
    
    var body: some View {
        ZStack {
            Color("backgroundSetting")
                .ignoresSafeArea()
            
            VStack {
                // Setting Tack Times
                HStack {
                    Text("Tack Times : ")
                        .font(.title)
                        .multilineTextAlignment(.trailing)

                    TextField(
                            "Input Number.",
                            value: $tackCount,
                            format: .number
                    )
                    .multilineTextAlignment(TextAlignment.leading)
                    .keyboardType(.numberPad)
                    .font(.title)
                    
                }
                Toggle(isOn: $midFlg) {
                    Text("Middle Sound Switch")
                        .font(.title)
                }
                .padding(7)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
