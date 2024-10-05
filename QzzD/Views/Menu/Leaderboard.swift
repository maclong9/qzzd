//
//  Lobby.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct Lobby: View {
    let players: [Player]
    let currentRound: Int
    @State private var animatedCards: [Bool]
    
    init(players: [Player], currentRound: Int) {
        self.players = players
        self._animatedCards = State(initialValue: Array(repeating: false, count: players.count))
        self.currentRound = currentRound
    }
    
    var body: some View {
        Layout(title: "Leaderboard") {
            Text("Round \(currentRound)")
                .fontWeight(.black)
            VStack(spacing: 10) {
                ForEach(Array(players.enumerated()), id: \.element.name) { index, player in
                    PlayerCard(currentRank: index + 1, player: player)
                        .offset(x: animatedCards[index] ? 0 : -300)
                        .opacity(animatedCards[index] ? 1 : 0)
                        .animation(.easeOut(duration: 0.3).delay(Double(index) * 0.05), value: animatedCards[index])
                }
            }
            .padding()
            .onAppear {
                animateCards()
            }
            Spacer()
            CButton(action: { print("Starting Round") }, fullWidth: true) {
                HStack {
                    Text("Next Round")
                    Image(systemName: "arrowshape.turn.up.forward.fill")
                }
            }
        }
    }
    
    private func animateCards() {
        for index in players.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                animatedCards[index] = true
            }
        }
    }
}

#Preview {
    Lobby(players: [
        Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
        Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
        Player(name: "Player Three", icon: "heart.fill", color: .blue, score: 80),
        Player(name: "Player Four", icon: "bolt.fill", color: .green, score: 70),
        Player(name: "Player Five", icon: "leaf.fill", color: .purple, score: 60),
        Player(name: "Player Six", icon: "flame.fill", color: .yellow, score: 80),
        Player(name: "Player Seven", icon: "drop.fill", color: .orange, score: 70),
        Player(name: "Player Eight", icon: "diamond.fill", color: .indigo, score: 60)
    ], currentRound: 5)
}
