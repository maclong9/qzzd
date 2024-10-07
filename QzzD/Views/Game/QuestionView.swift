//
//  QuestionView.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct QuestionView: View {
    let currentRound: Int
    let currentQuestion: Int
    let question: Question
    let isReader: Bool
    let hasBeenRead: Bool
    
    init(currentRound: Int, currentQuestion: Int, question: Question, isReader: Bool = false, hasBeenRead: Bool = false) {
        self.currentRound = currentRound
        self.currentQuestion = currentQuestion
        self.question = question
        self.isReader = isReader
        self.hasBeenRead = hasBeenRead
    }
    
    var body: some View {
        Layout(title: "Round \(currentRound)") {
            Spacer()
            VStack(spacing: 20) {
                Text("Question \(currentQuestion)/10")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                HStack {
                    InfoIndicator(
                        text: question.difficulty.rawValue,
                        icon: difficultyIcon,
                        color: difficultyColor
                    )
                    Spacer()
                    InfoIndicator(
                        text: question.category.rawValue,
                        icon: question.category.icon,
                        color: question.category.color
                    )
                }
                
                Text(question.question)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 64)
                
                Spacer()
                
                // TODO: Alter this to include if player has answered
                if isReader {
                    CButton(fullWidth: true) {
                        HStack {
                            Text(hasBeenRead ? "Question Read" : "Waiting")
                            if !hasBeenRead { Image(systemName: "rays") }
                            // TODO: add counter of players that have answered
                        }
                    }
                    .disabled(true)
                    .opacity(0.8)
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
        switch question.correctAnswer {
            case .string(let answer):
                let allAnswers = [answer] + (question.incorrectAnswers ?? [])
                return question.style == .normal ? allAnswers.shuffled() : ["True", "False"]
            case .boolean(let answer):
                return [String(answer).capitalized, String(!answer).capitalized]
        }
    }
    
    var difficultyIcon: String {
        switch question.difficulty {
            case .easy: return "dial.low.fill"
            case .medium: return "dial.medium.fill"
            case .hard: return "dial.high.fill"
        }
    }
    
    var difficultyColor: Color {
        switch question.difficulty {
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

#Preview("Multiple Choice") {
    QuestionView(
        currentRound: 5,
        currentQuestion: 4,
        question: Question(
            style: .normal,
            difficulty: .easy,
            category: .science,
            question: "Who designed the MacBook",
            correctAnswer: .string("Apple"),
            incorrectAnswers: ["McDonalds", "Microsoft", "Tesla"]
        ))
}

#Preview("Boolean") {
    QuestionView(
        currentRound: 6,
        currentQuestion: 8,
        question: Question(
            style: .boolean,
            difficulty: .medium,
            category: .entertainment,
            question: "Oppenheimer was shot for IMAX screens",
            correctAnswer: .boolean(true)
        ))
}

#Preview("Hard Question") {
    QuestionView(
        currentRound: 6,
        currentQuestion: 8,
        question: Question(
            style: .normal,
            difficulty: .hard,
            category: .art,
            question: "What was the name of the asylum Van Gogh admitted himself to",
            correctAnswer: .string("Saint-Paul"),
            incorrectAnswers: ["Saint-Bartholomew", "Saint-Pierre", "Saint-Pauline"]
            
        ))
}

#Preview("Player is Reader") {
    QuestionView(
        currentRound: 6,
        currentQuestion: 8,
        question: Question(
            style: .normal,
            difficulty: .medium,
            category: .entertainment,
            question: "What was the name of the asylum Van Gogh admitted himself to",
            correctAnswer: .string("Saint-Paul"),
            incorrectAnswers: ["Saint-Bartholomew", "Saint-Pierre", "Saint-Pauline"]
        ),
        isReader: true,
        hasBeenRead: false
    )
}

#Preview("Player is Reader and Question is Read") {
    QuestionView(
        currentRound: 6,
        currentQuestion: 8,
        question: Question(
            style: .normal,
            difficulty: .medium,
            category: .entertainment,
            question: "What was the name of the asylum Van Gogh admitted himself to",
            correctAnswer: .string("Saint-Paul"),
            incorrectAnswers: ["Saint-Bartholomew", "Saint-Pierre", "Saint-Pauline"]
        ),
        isReader: true,
        hasBeenRead: true
    )
}
