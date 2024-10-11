//
//  CreatePlayer.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct CreatePlayer: View {
    let isSoloGame: Bool
    let gameName: String?
    @State private var playerName = ""
    @State private var selectedColor: Color = .red
    @State private var selectedIcon = "person.fill"
    
    init(isSoloGame: Bool = false, gameName: String? = nil) {
        self.isSoloGame = isSoloGame
        self.gameName = gameName
    }
    
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .indigo, .teal]
    let icons = [
        "person.fill", "star.fill", "heart.fill", "bolt.fill",
        "leaf.fill", "flame.fill", "drop.fill", "diamond.fill",
        "car.fill", "paperplane.fill", "gamecontroller.fill", "music.note",
        "book.fill", "camera.fill", "gift.fill", "map.fill",
        "crown.fill", "flag.fill", "bell.fill", "pawprint.fill",
        "lightbulb.fill", "moon.fill", "sun.max.fill", "cloud.fill"
    ]
    
    var body: some View {
        Layout(title: isSoloGame ? "Solo Game" : gameName ?? "Join Game") {
            VStack(spacing: 20) {
                Text("Your Name")
                    .font(.headline)
                    .fontWeight(.black)
                TextField("Enter your name...", text: $playerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .shadow(radius: 1)
                Text("Choose your color")
                    .font(.headline)
                    .fontWeight(.black)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 10) {
                    ForEach(colors, id: \.self) { color in
                        ColorBox(color: color, isSelected: color == selectedColor)
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                }
                .padding(.horizontal, 50)
                Text("Choose your icon")
                    .font(.headline)
                    .fontWeight(.black)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 10) {
                    ForEach(icons, id: \.self) { icon in
                        IconBox(icon: icon, isSelected: icon == selectedIcon, playerColor: selectedColor)
                            .onTapGesture {
                                selectedIcon = icon
                            }
                    }
                }
                CButton(fullWidth: true) {
                    HStack {
                        Text(isSoloGame ? "Start Game": "Join Game")
                        Image(systemName: "arrowshape.turn.up.right.fill")
                    }
                }
            }.padding()
        }
    }
}

struct ColorBox: View {
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 44, height: 44)
            
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? Color.white : Color.clear, lineWidth: 3)
        )
    }
}

struct IconBox: View {
    let icon: String
    let isSelected: Bool
    let playerColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? playerColor : Color.gray.opacity(0.2))
                .frame(width: 44, height: 44)
            
            Image(systemName: icon)
                .foregroundColor(isSelected ? .white : .primary)
        }
    }
}

#Preview("Single Player") {
    CreatePlayer()
}

#Preview("Multiplayer") {
    CreatePlayer(gameName: "Some Game")
}
