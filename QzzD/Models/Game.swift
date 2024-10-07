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
    let players: [Player]
    let questions: [Question]
    let roundCount: Int
    let questionCount: Int
    let currentReader: String?
    
    init(title: String, players: [Player] = [], roundCount: Int = 0, questionCount: Int = 1, currentReader: String? = nil) {
        self.title = title
        self.players = players
        self.questions = questionsArray
        self.roundCount = roundCount
        self.questionCount = questionCount
        self.currentReader = currentReader
    }
    
    private let questionsArray: [Question] = [
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
