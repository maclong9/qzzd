//
//  Session.swift
//  QzzD
//
//  Created by Mac Long on 2024-10-11.
//

import Foundation

@Observable
class SessionData {
    var game: Game?
    
    init(game: Game? = nil) {
        self.game = game
    }
}
