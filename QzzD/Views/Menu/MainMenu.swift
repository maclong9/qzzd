//
//  MainMenu.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct MainMenu: View {
    @State private var showingAlert = false
    @State private var gameName: String = ""
    @State private var offsetY: CGFloat = 100
    @State private var opacity: Double = 0.0
    
    var body: some View {
        Layout(showBackButton: false, isMainMenu: true) {
            VStack {
                CButton(color: .indigo) {
                    Text("Solo Game")
                }
                .padding()
                
                Text("Multiplayer Game")
                    .font(.title)
                    .fontWeight(.black)
                HStack {
                    CButton(action: { showingAlert = true }, color: .teal) {
                        HStack {
                            Text("Create Game")
                            Image(systemName: "plus.circle")
                        }
                    }.alert("Game Title", isPresented: $showingAlert) {
                        TextField("Enter your games title", text: $gameName)
                        Text("Let's Go!")
                    }
                    
                    CButton(color: .blue) {
                        HStack {
                            Text("Join Game")
                            Image(systemName: "arrowshape.turn.up.right.fill")
                        }   
                    }
                }
            }
            .padding(.top, 100)
            .offset(y: offsetY)
            .opacity(opacity)
            .onAppear {
                withAnimation(.bouncy(duration: 0.6)) {
                  offsetY = 0
                  opacity = 1
                }
            }
        }
    }
}

#Preview {
    MainMenu()
}
