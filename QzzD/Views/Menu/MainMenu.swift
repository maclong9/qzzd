//
//  MainMenu.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct MainMenu: View {
    @State private var showingAlert = false
    @State private var offsetY: CGFloat = 100
    @State private var opacity: Double = 0.0
    @State private var gameName: String = ""
    @State private var navigateToCreatePlayer = false
    
    var body: some View {
        NavigationStack {
            Layout(isMainMenu: true) {
                VStack {
                    CButton(destination: { CreatePlayer(isSoloGame: true) }, color: .indigo) {
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
                        }
                        CButton(destination: { GameFinder() }, color: .blue) {
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
            .alert("Game Title", isPresented: $showingAlert) {
                TextField("Enter your game's title", text: $gameName)
                Button("Let's Go!") {
                    navigateToCreatePlayer = true
                    showingAlert = false
                }
            } message: {
                Text("Please enter a title for your game")
            }
            .navigationDestination(isPresented: $navigateToCreatePlayer) {
                CreatePlayer(isSoloGame: false, gameName: gameName)
            }
        }
    }
}

#Preview {
    MainMenu()
}
