//
//  GameFinder.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct GameFinder: View {
    @State var games: [Game] = []
    
    var body: some View {
        Layout(title: "Join a Game") {
            ScrollView {
                VStack {
                    ForEach(games) { game in
                        GameCard(game: game)
                            .onTapGesture {
                                if game.players.count < 8 {
                                    print("Joining game: \(game.title)...")
                                } else {
                                    print("Game is full.")
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct GameCard: View {
    let game: Game
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                
                Text(game.title)
                    .font(.headline)
                HStack(spacing: 2) {
                    Image(systemName: "person.2.fill")
                    Text("\(game.players.count)/8")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    GameFinder(games: [
        Game(title: "Hello, world", players: [
            Player(name: "Testing", icon: "gamecontroller.fill", color: Color.red, score: 120),
            Player(name: "Player 3", icon: "person.fill", color: Color.green, score: 100),
            Player(name: "Player 4", icon: "star.fill", color: Color.yellow, score: 80),
            Player(name: "Test", icon: "paperplane.fill", color: Color.brown, score: 150),
            Player(name: "Tset", icon: "book.fill", color: Color.orange, score: 60),
            Player(name: "Gnitset", icon: "camera.fill", color: Color.purple, score: 40),
            Player(name: "Player 7", icon: "gift.fill", color: Color.pink, score: 20),
            Player(name: "Player 8", icon: "map.fill", color: Color.teal, score: 10)
        ]),
        Game(title: "Some Other Game", players: [
            Player(name: "Testing", icon: "gamecontroller.fill", color: Color.red, score: 120),
            Player(name: "Player 3", icon: "person.fill", color: Color.green, score: 100),
        ]),
        Game(title: "A Third Game!", players: [
            Player(name: "Tset", icon: "book.fill", color: Color.orange, score: 60),
            Player(name: "Gnitset", icon: "camera.fill", color: Color.purple, score: 40),
            Player(name: "Player 7", icon: "gift.fill", color: Color.pink, score: 20),
        ])
    ])
}
