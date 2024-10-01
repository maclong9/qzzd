//
//  Question.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import Foundation

enum Style { case multiple, boolean }
enum Difficulty { case easy, medium, hard }

struct Question: Identifiable {
    let id: UUID
    let type: Style
    let question: String
    let difficulty: Difficulty
    let category: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
