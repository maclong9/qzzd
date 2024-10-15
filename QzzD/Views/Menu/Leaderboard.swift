//
//  Lobby.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct Leaderboard: View {
    let players: [Player]
    let currentRound: Int
    let gameName: String
    let onNextRound: () -> Void
    @State private var animatedCards: [Bool]
    
    init(players: [Player], currentRound: Int, gameName: String, onNextRound: @escaping () -> Void) {
        self.players = players
        self._animatedCards = State(initialValue: Array(repeating: false, count: players.count))
        self.currentRound = currentRound
        self.gameName = gameName
        self.onNextRound = onNextRound
    }
    
    var body: some View {
        Layout(title: "Round \(currentRound)") {
            VStack(spacing: 5) {
                ForEach(Array(players.sorted(by: { $0.score > $1.score }).enumerated()), id: \.element.name) { index, player in
                    PlayerCard(currentRank: index + 1, player: player)
                        .offset(x: animatedCards[index] ? 0 : -300)
                        .opacity(animatedCards[index] ? 1 : 0)
                        .animation(.easeOut(duration: 0.3).delay(Double(index) * 0.075), value: animatedCards[index])
                }
                CButton(action: onNextRound, fullWidth: true) {
                    HStack {
                        Text("Next Round")
                        Image(systemName: "arrowshape.turn.up.forward.fill")
                    }
                }
            }
            .onAppear {
                animateCards()
            }
        }
        .padding(.horizontal)
    }
    
    private func animateCards() {
        for index in players.indices {
            withAnimation(.easeOut(duration: 0.3).delay(Double(index) * 0.05)) {
                animatedCards[index] = true
            }
        }
    }
}

#Preview {
    Leaderboard(players: [
        Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
        Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
        Player(name: "Player Three", icon: "heart.fill", color: .blue, score: 80),
        Player(name: "Player Four", icon: "bolt.fill", color: .green, score: 70),
        Player(name: "Player Five", icon: "leaf.fill", color: .purple, score: 60),
        Player(name: "Player Six", icon: "flame.fill", color: .yellow, score: 80),
        Player(name: "Player Seven", icon: "drop.fill", color: .orange, score: 70),
        Player(name: "Player Eight", icon: "diamond.fill", color: .indigo, score: 60)
    ], currentRound: 5, gameName: "Some Game", onNextRound: { print("Starting Round...")})
}
