//
//  PlayerControllerTests.swift
//  QzzD
//
//  Created by Mac Long on 05/10/2024.
//

import Testing
import SwiftUI
@testable import QzzD

struct PlayerTests {
    @Test
    func testPlayerInitialization() throws {
        let player = Player(name: "John", icon: "person.fill", color: .blue, score: 0)
        
        #expect(player.name == "John")
        #expect(player.icon == "person.fill")
        #expect(player.color == .blue)
        #expect(player.score == 0)
    }
    
    @Test
    func testIncrementScoreEasyDifficulty() throws {
        var player = Player(name: "Alice", icon: "star.fill", color: .green, score: 0)
        player.incrementScore(difficulty: .easy, time: 5)
        
        // Expected score: 100 (base) + 50 (time bonus) = 150
        #expect(player.score == 150)
    }
    
    @Test
    func testIncrementScoreMediumDifficulty() throws {
        var player = Player(name: "Bob", icon: "heart.fill", color: .red, score: 0)
        player.incrementScore(difficulty: .medium, time: 5)
        
        // Expected score: 200 (base) + 100 (time bonus) = 300
        #expect(player.score == 300)
    }
    
    @Test
    func testIncrementScoreHardDifficulty() throws {
        var player = Player(name: "Charlie", icon: "bolt.fill", color: .purple, score: 0)
        player.incrementScore(difficulty: .hard, time: 5)
        
        // Expected score: 300 (base) + 150 (time bonus) = 450
        #expect(player.score == 450)
    }
    
    @Test
    func testIncrementScoreMaxTime() throws {
        var player = Player(name: "David", icon: "leaf.fill", color: .orange, score: 0)
        player.incrementScore(difficulty: .medium, time: 10)
        
        // Expected score: 200 (base) + 0 (time bonus) = 200
        #expect(player.score == 200)
    }
    
    @Test
    func testIncrementScoreMultipleTimes() throws {
        var player = Player(name: "Eve", icon: "flame.fill", color: .yellow, score: 0)
        player.incrementScore(difficulty: .easy, time: 5)
        player.incrementScore(difficulty: .medium, time: 5)
        player.incrementScore(difficulty: .hard, time: 5)
        
        // Expected score: 150 + 300 + 450 = 900
        #expect(player.score == 900)
    }
}
