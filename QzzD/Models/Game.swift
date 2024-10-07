//
//  Game.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import Foundation

struct Game: Identifiable {
    let id = UUID()
    let title: String
    var players: [Player]
    var questions: [Question]
    var roundCount: Int
    var questionCount: Int
    var currentReader: Player
    
    init(title: String, players: [Player] = [], roundCount: Int = 0, questionCount: Int = 1, currentReader: Player? = nil) {
        self.title = title
        self.players = players
        self.roundCount = roundCount
        self.questionCount = questionCount
        self.currentReader = currentReader ?? players.first!
        self.questions = [
            Question(
                style: .boolean,
                difficulty: .easy,
                category: .science,
                question: "Apple designed the MacBook",
                correctAnswer: .boolean(true)
            ),
            Question(
                style: .normal,
                difficulty: .medium,
                category: .science,
                question: "Who made the original Apple Computer?",
                correctAnswer: .string("Steve Wozniak"),
                incorrectAnswers: ["Steve Jobs", "Barry Allen", "Elon Musk"]
            ),
            Question(
                style: .boolean,
                difficulty: .hard,
                category: .science,
                question: "Steve Jobs threw an iPod in a fish tank",
                correctAnswer: .boolean(true)
            )
        ]
    }
    
    mutating func addPlayer(_ player: Player) {
        players.append(player)
    }
    
    mutating func removePlayer(_ player: Player) {
        players.removeAll(where: { $0.id == player.id })
    }
    
    mutating func nextQuestion() {
        if questionCount < 10 {
            questionCount += 1
        } else {
            currentReader = players.shuffled().first!
            questionCount = 0
            roundCount += 1
        }
    }
}
