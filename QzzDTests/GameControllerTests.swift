//
//  GameControllerTests.swift
//  QzzD
//
//  Created by Mac Long on 05/10/2024.
//

import Testing
import SwiftUI
@testable import QzzD

struct GameTests {
    
    func createTestPlayers() -> [Player] {
        return [
            Player(name: "Alice", icon: "person.fill", color: .red, score: 0),
            Player(name: "Bob", icon: "star.fill", color: .blue, score: 0),
            Player(name: "Charlie", icon: "heart.fill", color: .green, score: 0)
        ]
    }
    
    @Test
    func testGameInitialization() throws {
        let players = createTestPlayers()
        let game = Game(title: "Test Game", players: players, roundCount: 1, questionCount: 1, currentReader: players[0])
        
        #expect(game.title == "Test Game")
        #expect(game.players.count == 3)
        #expect(game.roundCount == 1)
        #expect(game.questionCount == 1)
        #expect(game.currentReader.name == "Alice")
        #expect(game.questions.count == 3)
    }
    
    @Test
    func testGameInitializationWithDefaultValues() throws {
        let players = createTestPlayers()
        let game = Game(title: "Default Game", players: players)
        
        #expect(game.title == "Default Game")
        #expect(game.players.count == 3)
        #expect(game.roundCount == 0)
        #expect(game.questionCount == 1)
        #expect(game.currentReader.name == "Alice")
        #expect(game.questions.count == 3)
    }
    
    @Test
    func testAddPlayer() throws {
        var game = Game(title: "Add Player Game", players: createTestPlayers())
        let newPlayer = Player(name: "David", icon: "bolt.fill", color: .yellow, score: 0)
        
        game.addPlayer(newPlayer)
        
        #expect(game.players.count == 4)
        #expect(game.players.last?.name == "David")
    }
    
    @Test
    func testRemovePlayer() throws {
        var game = Game(title: "Remove Player Game", players: createTestPlayers())
        let playerToRemove = game.players[1]
        
        game.removePlayer(playerToRemove)
        
        #expect(game.players.count == 2)
        #expect(!game.players.contains(where: { $0.id == playerToRemove.id }))
    }
    
    @Test
    func testNextQuestionNormal() throws {
        var game = Game(title: "Next Question Game", players: createTestPlayers())
        let initialQuestionCount = game.questionCount
        let initialQuestionsArrayCount = game.questions.count
        
        game.nextQuestion()
        
        #expect(game.questionCount == initialQuestionCount + 1)
        #expect(game.questions.count == initialQuestionsArrayCount - 1)
    }
    
    @Test
    func testNextQuestionRoundChange() throws {
        var game = Game(title: "Round Change Game", players: createTestPlayers(), questionCount: 10)
        let initialRoundCount = game.roundCount
        let initialReader = game.currentReader

        game.nextQuestion()
        
        #expect(game.roundCount == initialRoundCount + 1)
        #expect(game.questionCount == 0)
        #expect(game.currentReader.id != initialReader.id)
    }
}
