//
//  NextRound.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct NextRoundView: View {
    var isReader: Bool = false
    @State var round: Int
    @State private var rotationAngle: Double = 0
    
    
    var body: some View {
        Layout(title: "Get Ready") {
            Spacer().frame(height: 125)
            RollingText(round: $round)
            Spacer()
            if isReader {
                CButton(action: { print("Reading Question") }, fullWidth: true) {
                    Text("See Question")
                    Image(systemName: "arrowshape.turn.up.forward.fill")
                }
            } else {
                CButton(action: { print("Waiting...") }, fullWidth: true, disabled: true) {
                    Text("Waiting")
                    Image(systemName: "rays")
                }.disabled(true).opacity(0.8)
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
