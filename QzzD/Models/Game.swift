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
    let answered: [Question]
    let roundCount: Int
    let questionCount: Int
    let currentQuestion: Question?
    let currentReader: Player?
    
    init(title: String, players: [Player] = [], answered: [Question] = [], roundCount: Int = 0, questionCount: Int = 1, currentQuestion: Question? = nil, currentReader: Player? = nil) {
        self.title = title
        self.players = players
        self.answered = answered
        self.roundCount = roundCount
        self.questionCount = questionCount
        self.currentQuestion = currentQuestion
        self.currentReader = currentReader
    }
}
