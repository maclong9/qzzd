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
}
