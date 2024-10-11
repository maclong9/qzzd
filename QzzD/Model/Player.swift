//
//  Player.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import Foundation
import SwiftUI

struct Player: Equatable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    var score: Int
    
    mutating func incrementScore(difficulty: Difficulty, time: TimeInterval) {
        let baseScore: Int
        switch difficulty {
            case .easy: baseScore = 100
            case .medium: baseScore = 200
            case .hard: baseScore = 300
        }
        
        let timeRatio = 1 - (time / 10)
        let timeBonus = Int(Double(baseScore) * timeRatio)
        
        score += baseScore + timeBonus
    }
}
