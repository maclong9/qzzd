//
//  QuestionView.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct QuestionView: View {
    let game: Game
    let player: Player
    var playerAnswered: Bool
    var hasBeenRead: Bool
    @State var totalAnswerCount: Int = 0
    
    init(game: Game, player: Player, playerAnswered: Bool?, hasBeenRead: Bool?) {
        self.game = game
        self.player = player
        self.playerAnswered = playerAnswered ?? false
        self.hasBeenRead = hasBeenRead ?? false
    }
    
    var currentQuestion: Question {
        game.questions[game.questionCount]
    }
    
    var body: some View {
        Layout(title: "Round \(game.roundCount)") {
            Spacer()
            VStack(spacing: 20) {
                Text("Question \(game.questionCount)/10")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                HStack {
                    InfoIndicator(
                        text: currentQuestion.difficulty.rawValue,
                        icon: difficultyIcon,
                        color: difficultyColor
                    )
                    Spacer()
                    InfoIndicator(
                        text: currentQuestion.category.rawValue,
                        icon: currentQuestion.category.icon,
                        color: currentQuestion.category.color
                    )
                }
                
                Text(currentQuestion.question)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 64)
                
                Spacer()
                
                if game.currentReader?.name == player.name || playerAnswered {
                    CButton(fullWidth: true) {
                        HStack {
                            Text(hasBeenRead ? "Waiting \(totalAnswerCount)/\(game.players.count)" : "Mark Question as Read")
                        }
                    }
                    .disabled(hasBeenRead)
                } else {
                    VStack(spacing: 12) {
                        ForEach(answerOptions, id: \.self) { answer in
                            CButton(action: {
                                print("Selected answer: \(answer)")
                            }, fullWidth: true) {
                                Text(answer)
                                    .lineLimit(3)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    var answerOptions: [String] {
        switch currentQuestion.correctAnswer {
            case .string(let answer):
                let allAnswers = [answer] + (currentQuestion.incorrectAnswers ?? [])
                return currentQuestion.style == .normal ? allAnswers.shuffled() : ["True", "False"]
            case .boolean(let answer):
                return [String(answer).capitalized, String(!answer).capitalized]
        }
    }
    
    var difficultyIcon: String {
        switch currentQuestion.difficulty {
            case .easy: return "dial.low.fill"
            case .medium: return "dial.medium.fill"
            case .hard: return "dial.high.fill"
        }
    }
    
    var difficultyColor: Color {
        switch currentQuestion.difficulty {
            case .easy: return .green
            case .medium: return .orange
            case .hard: return .red
        }
    }
}

struct InfoIndicator: View {
    let text: String
    let icon: String
    let color: Color
    
    var body: some View {
        Label {
            Text(text)
        } icon: {
            Image(systemName: icon)
        }
        .font(.headline)
        .fontWeight(.heavy)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

#Preview("Boolean") {
    QuestionView(
        game: Game(
            title: "Test Game",
            players: [
                Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
                Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
                Player(name: "Player Three", icon: "heart.fill", color: .blue, score: 80),
            ],
            questionCount: 0,
            currentReader: Player(name: "Player Two", icon: "star.fill", color: .red, score: 90)
        ),
        player: Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
        playerAnswered: false,
        hasBeenRead: false
    )
}


#Preview("Multiple Choice") {
    QuestionView(
        game: Game(
            title: "Test Game",
            players: [
                Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
                Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
                Player(name: "Player Three", icon: "heart.fill", color: .blue, score: 80),
            ],
            questionCount: 1,
            currentReader: Player(name: "Player One", icon: "person.fill", color: .teal, score: 100)
        ),
        player: Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
        playerAnswered: false,
        hasBeenRead: false
    )
}

#Preview("Hard Question") {
    QuestionView(
        game: Game(
            title: "Test Game",
            players: [
                Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
                Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
                Player(name: "Player Three", icon: "heart.fill", color: .blue, score: 80),
            ],
            questionCount: 2,
            currentReader: Player(name: "Player One", icon: "person.fill", color: .teal, score: 100)
        ),
        player: Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
        playerAnswered: false,
        hasBeenRead: false
    )
}

#Preview("Question has been Answered") {
    QuestionView(
        game: Game(
            title: "Test Game",
            players: [
                Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
                Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
                Player(name: "Player Three", icon: "heart.fill", color: .blue, score: 80),
            ],
            currentReader: Player(name: "Player One", icon: "person.fill", color: .teal, score: 100)
        ),
        player: Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
        playerAnswered: true,
        hasBeenRead: true
    )
}

#Preview("Player is Reader") {
    QuestionView(
        game: Game(
            title: "Test Game",
            players: [
                Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
                Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
                Player(name: "Player Three", icon: "heart.fill", color: .blue, score: 80),
            ],
            currentReader: Player(name: "Player Two", icon: "star.fill", color: .red, score: 90)
        ),
        player: Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
        playerAnswered: false,
        hasBeenRead: false
    )
}

#Preview("Player Is Reader and Question Is Read") {
    QuestionView(
        game: Game(
            title: "Test Game",
            players: [
                Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
                Player(name: "Player Two", icon: "star.fill", color: .red, score: 90),
                Player(name: "Player Three", icon: "heart.fill", color: .blue, score: 80),
            ],
            currentReader: Player(name: "Player One", icon: "person.fill", color: .teal, score: 100)
        ),
        player: Player(name: "Player One", icon: "person.fill", color: .teal, score: 100),
        playerAnswered: true,
        hasBeenRead: true
    )
}
