//
//  NextRound.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct NextRoundView: View {
    var round: Int
    var isReader: Bool = false
    
    var body: some View {
        Layout(title: "Get Ready") {
            Spacer().frame(height: 125)
            RollingText(round: round)
            Spacer()
            
            if isReader {
                CButton(action: { print("Reading Question") }, fullWidth: true) {
                    HStack {
                        Text("See Question")
                        Image(systemName: "arrowshape.turn.up.forward.fill")
                    }
                }
            } else {
                CButton(fullWidth: true) {
                    HStack {
                        Text("Waiting")
                        Image(systemName: "rays")
                    }
                }
                .disabled(true)
                .opacity(0.8)
            }
        }
    }
}

#Preview("Single Digit") {
    NextRoundView(round: 8)
}

#Preview("Double Digit") {
    NextRoundView(round: 64)
}

#Preview("Triple Digit") {
    NextRoundView(round: 256)
}
