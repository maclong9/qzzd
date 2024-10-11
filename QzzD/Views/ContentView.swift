//
//  ContentView.swift
//  QzzD
//
//  Created by Mac Long on 2024-10-11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainMenu()
    }
}

#Preview {
    ContentView()
        .environment(SessionData())
}
