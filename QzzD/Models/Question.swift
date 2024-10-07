//
//  Question.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

enum QuestionStyle {
    case normal,
         boolean
}

enum Difficulty: String {
    case easy = "Easy",
         medium = "Medium",
         hard = "Hard"
}

enum QuizCategory: String, Codable, CaseIterable {
    case generalKnowledge = "General Knowledge",
         entertainment = "Entertainment",
         science = "Science",
         mythology = "Mythology",
         sports = "Sports",
         geography = "Geography",
         history = "History",
         politics = "Politics",
         art = "Art",
         celebrities = "Celebrities",
         animals = "Animals",
         vehicles = "Vehicles"
    
    var icon: String {
        switch self {
            case .generalKnowledge: return "lightbulb.fill"
            case .entertainment: return "tv.fill"
            case .science: return "atom"
            case .mythology: return "cloud.bolt.fill"
            case .sports: return "sportscourt.fill"
            case .geography: return "globe.americas.fill"
            case .history: return "clock.fill"
            case .politics: return "building.columns.fill"
            case .art: return "paintpalette.fill"
            case .celebrities: return "star.fill"
            case .animals: return "pawprint.fill"
            case .vehicles: return "car.fill"
        }
    }
    
    var color: Color {
        switch self {
            case .generalKnowledge: return .blue
            case .entertainment: return .purple
            case .science: return .green
            case .mythology: return .yellow
            case .sports: return .orange
            case .geography: return .cyan
            case .history: return .brown
            case .politics: return .red
            case .art: return .pink
            case .celebrities: return .indigo
            case .animals: return .mint
            case .vehicles: return .teal
        }
    }
}

struct Question {
    enum Answer {
        case string(String),
             boolean(Bool)
    }
    
    let id = UUID()
    let style: QuestionStyle
    let difficulty: Difficulty
    let category: QuizCategory
    let question: String
    let correctAnswer: Answer
    let incorrectAnswers: [String]?
    
    init(style: QuestionStyle, difficulty: Difficulty, category: QuizCategory, question: String, correctAnswer: Answer, incorrectAnswers: [String]? = nil) {
        self.style = style
        self.difficulty = difficulty
        self.category = category
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}
