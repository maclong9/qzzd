//
//  NextRound.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct NextRound: View {
    var round: Int
    
    var body: some View {
        Layout(title: "Get Ready") {
            Spacer().frame(height: 125)
            RollingText(round: round)
            Spacer()
        }
    }
}

#Preview("Single Digit") {
    NextRound(round: 64)
}

#Preview("Double Digit") {
    NextRound(round: 64)
}

#Preview("Triple Digit") {
    NextRound(round: 256)
}
