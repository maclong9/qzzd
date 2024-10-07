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
    let answeredQuestions: [Question]
    let roundCount: Int
    let questionCount: Int
    let currentQuestion: Question?
    let currentReader: String?
    
    init(title: String, players: [Player] = [], answeredQuestions: [Question] = [], roundCount: Int = 0, questionCount: Int = 1, currentQuestion: Question? = nil, currentReader: String? = nil) {
        self.title = title
        self.players = players
        self.questions = questionsArray
        self.answeredQuestions = answeredQuestions
        self.roundCount = roundCount
        self.questionCount = questionCount
        self.currentQuestion = currentQuestion
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
            difficulty: .easy,
            category: .science,
            question: "Who designed the MacBook",
            correctAnswer: .string("Apple"),
            incorrectAnswers: ["McDonalds", "Microsoft", "Tesla"]
        )
    ]
}
