//
//  QuestionView.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct QuestionView: View {
    let game: Game
    let player: String
    var playerAnswered: Bool
    var hasBeenRead: Bool
    
    init(game: Game, player: String, playerAnswered: Bool?, hasBeenRead: Bool?) {
        self.game = game
        self.player = player
        self.playerAnswered = playerAnswered ?? false
        self.hasBeenRead = hasBeenRead ?? false
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
                        text: game.currentQuestion!.difficulty.rawValue,
                        icon: difficultyIcon,
                        color: difficultyColor
                    )
                    Spacer()
                    InfoIndicator(
                        text: game.currentQuestion!.category.rawValue,
                        icon: game.currentQuestion!.category.icon,
                        color: game.currentQuestion!.category.color
                    )
                }
                
                Text(game.currentQuestion!.question)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 64)
                
                Spacer()
                
                if game.currentReader == player || playerAnswered {
                    CButton(fullWidth: true) {
                        HStack {
                            Text(hasBeenRead ? "Waiting" : "Question Read")
                            // TODO: add counter of players that have answered
                            if hasBeenRead { Image(systemName: "rays") }
                        }
                    }
                    .disabled(hasBeenRead ? true : false)
                } else {
                    VStack(spacing: 12) {
                        ForEach(answerOptions, id: \.self) { answer in
                            CButton(action: {
                                print("Selected answer: \(answer)")
                            },  fullWidth: true) {
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
        switch game.currentQuestion!.correctAnswer {
            case .string(let answer):
                let allAnswers = [answer] + (game.currentQuestion!.incorrectAnswers ?? [])
                return game.currentQuestion!.style == .normal ? allAnswers.shuffled() : ["True", "False"]
            case .boolean(let answer):
                return [String(answer).capitalized, String(!answer).capitalized]
        }
    }
    
    var difficultyIcon: String {
        switch game.currentQuestion!.difficulty {
            case .easy: return "dial.low.fill"
            case .medium: return "dial.medium.fill"
            case .hard: return "dial.high.fill"
        }
    }
    
    var difficultyColor: Color {
        switch game.currentQuestion!.difficulty {
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
            currentQuestion: Question(
                style: .boolean,
                difficulty: .easy,
                category: .science,
                question: "Apple designed the MacBook",
                correctAnswer: .boolean(true)
            ),
            currentReader: "Player Two"
        ),
        player: "Player One",
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
            currentQuestion: Question(
                style: .normal,
                difficulty: .medium,
                category: .science,
                question: "Who designed the MacBook?",
                correctAnswer: .string("Apple"),
                incorrectAnswers: ["McDonalds", "Microsoft", "Tesla"]
            ),
            currentReader: "Player One"
        ),
        player: "Player Two",
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
            currentQuestion: Question(
                style: .normal,
                difficulty: .hard,
                category: .history,
                question: "In which year did the French Revolution begin?",
                correctAnswer: .string("1789"),
                incorrectAnswers: ["1776", "1804", "1815"]
            ),
            currentReader: "Player One"
        ),
        player: "Player Two",
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
            currentQuestion: Question(
                style: .normal,
                difficulty: .easy,
                category: .geography,
                question: "What is the capital of France?",
                correctAnswer: .string("Paris"),
                incorrectAnswers: ["London", "Tokyo", "New York"]
            ),
            currentReader: "Player One"
        ),
        player: "Player Two",
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
            currentQuestion: Question(
                style: .normal,
                difficulty: .medium,
                category: .entertainment,
                question: "Who played Tony Stark in the Marvel Cinematic Universe?",
                correctAnswer: .string("Robert Downey Jr."),
                incorrectAnswers: ["Chris Evans", "Chris Hemsworth", "Mark Ruffalo"]
            ),
            currentReader: "Player Two"
        ),
        player: "Player Two",
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
            currentQuestion: Question(
                style: .normal,
                difficulty: .medium,
                category: .geography,
                question: "What is the capital of Australia?",
                correctAnswer: .string("Canberra"),
                incorrectAnswers: ["Sydney", "Melbourne", "Perth"]
            ),
            currentReader: "Player One"
        ),
        player: "Player One",
        playerAnswered: true,
        hasBeenRead: true
    )
}
