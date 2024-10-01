//
//  RollingText.swift
//  QzzD
//
//  Created by Mac Long on 01/10/2024.
//

import SwiftUI

struct RollingText: View {
    var round: Int
    @State private var animationRange: [Int] = []
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<animationRange.count, id: \.self) { index in
                Text("0")
                    .font(.system(size: 150, weight: .black))
                    .opacity(0)
                    .overlay {
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            VStack(spacing: 0) {
                                ForEach(0...9, id: \.self) { number in
                                    Text("\(number)")
                                        .font(.system(size: 150, weight: .black))
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                            }
                            .offset(y: -CGFloat(animationRange[index]) * size.height)
                        }
                        .clipped()
                    }
            }
        }
        .onAppear {
            initializeAnimationRange()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                updateText()
            }
        }
    }
    
    private func initializeAnimationRange() {
        animationRange = Array(repeating: 0, count: "\(round)".count)
    }
    
    private func updateText() {
        let stringValue = "\(round)"
        for (index, value) in zip(0..<stringValue.count, stringValue) {
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 1, blendDuration: 1)) {
                animationRange[index] = Int(String(value)) ?? 0
            }
        }
    }
}

#Preview {
    NextRoundView(round: 954)
}
