//
//  Game.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

struct Game {
    let name: String
    let players: [Player] = []
    let answered: [Question]
    let roundCount: Int = 0
    let questionCount: Int = 0
    let currentQuestion: Question? = nil
    let currentReader: Player? = nil
}
