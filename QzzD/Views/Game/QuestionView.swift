//
//  QuestionView.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    let questionNumber: Int
    
    var body: some View {
        Layout(title: "Question \(questionNumber)/10") {
            VStack {
                Text(question.question)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                HStack {
                    
                }
            }
        }
    }
}

import Foundation

#Preview("Multiple Choice") {
    QuestionView(question: Question(id: UUID(), type: .multiple, question: "Who designs the MacBook Pro?", difficulty: .easy, category: "Science", correctAnswer: "Apple", incorrectAnswers: ["Microsoft", "Tesla", "McDonalds"]), questionNumber: 1)
}
