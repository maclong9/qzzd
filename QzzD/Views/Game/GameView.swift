//
//  GameView.swift
//  QzzD
//
//  Created by Mac Long on 2024-10-15.
//

import SwiftUI

struct GameView: View {
    @State private var game: Game
    @State private var showingLeaderboard: Bool = true
    @State private var showingNextRound: Bool = false
    @State private var questionHasBeenRead: Bool = false
    
    init(game: Game) {
        _game = State(initialValue: game)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if showingLeaderboard {
                    Leaderboard(players: game.players, currentRound: game.roundCount, gameName: game.title, onNextRound: startNextRound)
                        .transition(.opacity)
                } else if showingNextRound {
                    NextRound(round: game.roundCount)
                        .transition(.opacity)
                } else {
                    QuestionView(
                        game: game,
                        player: game.currentReader ?? game.players[0],
                        playerAnswered: false,
                        hasBeenRead: $questionHasBeenRead
                    )
                    .transition(.opacity)
                }
            }
            .animation(.default, value: showingLeaderboard)
            .animation(.default, value: showingNextRound)
        }
        .onChange(of: game.questionCount) { oldValue, newValue in
            if newValue == 10 {
                endRound()
            }
        }
    }
    
    private func endRound() {
        withAnimation {
            showingLeaderboard = true
            showingNextRound = false
        }
        game.nextQuestion()
    }
    
    private func startNextRound() {
        withAnimation {
            showingLeaderboard = false
            showingNextRound = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showingNextRound = false
            }
        }
    }
    
    private func nextQuestion() {
        game.nextQuestion()
    }
}

#Preview {
    GameView(
        game: Game(title: "Hello, world", players: [
            Player(name: "Testing", icon: "gamecontroller.fill", color: Color.red, score: 120),
            Player(name: "Player 3", icon: "person.fill", color: Color.green, score: 100),
            Player(name: "Player 4", icon: "star.fill", color: Color.yellow, score: 80),
            Player(name: "Test", icon: "paperplane.fill", color: Color.brown, score: 150),
            Player(name: "Tset", icon: "book.fill", color: Color.orange, score: 60),
            Player(name: "Gnitset", icon: "camera.fill", color: Color.purple, score: 40),
            Player(name: "Player 7", icon: "gift.fill", color: Color.pink, score: 20),
            Player(name: "Player 8", icon: "map.fill", color: Color.teal, score: 10)
        ])
    )
}
