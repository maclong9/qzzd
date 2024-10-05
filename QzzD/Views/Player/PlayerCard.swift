//
//  PlayerCard.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct MetallicGlowModifier: ViewModifier {
    let rank: Int
    @State private var animationPhase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                glowOverlay
                    .mask(content)
            )
            .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: animationPhase)
            .onAppear {
                animationPhase = 1
            }
    }
    
    @ViewBuilder
    private var glowOverlay: some View {
        switch rank {
            case 1:
                LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.5), Color.yellow, Color.orange, Color.yellow.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .offset(x: -50 + 150 * animationPhase, y: -50 + 150 * animationPhase)
            case 2:
                LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.white, Color.gray, Color.gray.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .offset(x: -50 + 150 * animationPhase, y: -50 + 150 * animationPhase)
            case 3:
                LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.5), Color.orange, Color.brown, Color.orange.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .offset(x: -50 + 150 * animationPhase, y: -50 + 150 * animationPhase)
            default:
                EmptyView()
        }
    }
}

struct PlayerCard: View {
    let currentRank: Int
    let player: Player
    
    private var medalColor: Color {
        switch currentRank {
            case 1: return .yellow
            case 2: return .gray
            case 3: return .orange
            default: return .clear
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(currentRank)")
                    .font(.headline)
                    .fontWeight(.black)
                    .padding(.trailing, 10)
                    .modifier(MetallicGlowModifier(rank: currentRank))
                Image(systemName: player.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(player.color)
                Text(player.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text("\(player.score)")
                    .font(.subheadline)
                    .fontWeight(.black)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    VStack {
        PlayerCard(currentRank: 1, player: Player(name: "Player One", icon: "person.crop.circle.fill", color: .teal, score: 100))
        PlayerCard(currentRank: 2, player: Player(name: "Player Two", icon: "person.crop.circle.fill", color: .red, score: 90))
        PlayerCard(currentRank: 3, player: Player(name: "Player Three", icon: "person.crop.circle.fill", color: .blue, score: 80))
        PlayerCard(currentRank: 4, player: Player(name: "Player Four", icon: "person.crop.circle.fill", color: .green, score: 70))
        PlayerCard(currentRank: 5, player: Player(name: "Player Five", icon: "person.crop.circle.fill", color: .purple, score: 60))
    }.padding()
}
