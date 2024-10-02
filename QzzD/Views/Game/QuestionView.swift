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
            .padding(.horizontal)
        }
    }
    
    var answerOptions: [String] {
        switch question.correctAnswer {
            case .string(let answer):
                let allAnswers = [answer] + (question.incorrectAnswers ?? [])
                return question.style == .normal ? allAnswers.shuffled() : ["True", "False"]
            case .boolean(let answer):
                return [String(answer), String(!answer)]
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
            difficulty: .easy,
            category: .science,
            question: "Apple designed the MacBook",
            correctAnswer: .boolean(true)
        ))
}
