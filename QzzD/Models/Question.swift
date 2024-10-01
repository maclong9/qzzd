//
//  Question.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

enum Style { case multiple, boolean }
enum Difficulty { case easy, medium, hard }

struct Question {
    let type: Style
    let question: String
    let difficulty: Difficulty
    let category: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
