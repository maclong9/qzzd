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
    @State var questionRead: Bool = false
    
    var body: some View {
        Layout(title: "Get Ready") {
            Spacer().frame(height: 125)
            RollingText(round: round)
            Spacer()
            
            if isReader {
                CButton(action: { print("Reading Question") }, fullWidth: true) {
                    Text("See Question")
                    Image(systemName: "arrowshape.turn.up.forward.fill")
                }
            } else {
                CButton(action: { print("Viewing Question") }, fullWidth: true, disabled: true) {
                    Text(!questionRead ? "Waiting" : "Answer Question")
                    if !questionRead {
                        // TODO: Add animation to loading spinner
                        Image(systemName: "rays")
                    }
                }
                .disabled(!questionRead)
                .opacity(!questionRead ? 0.8 : 1)
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
