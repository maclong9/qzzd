//
//  CButton.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct CButton<Content: View>: View {
    let action: (() -> Void)?
    let color: Color
    let fullWidth: Bool
    let content: () -> Content
    
    init(action: (() -> Void)? = nil, color: Color = .blue, fullWidth: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.color = color
        self.fullWidth = fullWidth
        self.content = content
    }
    
    var body: some View {
        Button {
            action?()
        } label: {
            content()
                .frame(maxWidth: fullWidth ? .infinity : nil)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
                .fontWeight(.bold)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        // Default Button
        CButton(action: { print("Default button") }) {
            Text("Default Button")
        }
        
        // Colored Button
        CButton(action: { print("Indigo button") }, color: .indigo) {
            Text("Red Button")
        }
        
        // Full width button
        CButton(action: { print("Full width button") }, fullWidth: true) {
            Text("Full Width Button")
        }
        
        // Full width colored button
        CButton(action: { print("Full width green button") }, color: .teal, fullWidth: true) {
            Text("Full Width Green Button")
        }
        
        // Button with left icon
        CButton(action: { print("Left icon button") }) {
            HStack {
                Image(systemName: "star.fill")
                Text("Favorite")
            }
        }
        
        // Button with right icon
        CButton(action: { print("Right icon button") }) {
            HStack {
                Text("Settings")
                Image(systemName: "gearshape.fill")
            }
        }
        
        // Button with icons on both sides
        CButton(action: { print("Both sides icons") }, fullWidth: true) {
            HStack {
                Image(systemName: "arrow.left")
                Spacer()
                Text("Navigate")
                Spacer()
                Image(systemName: "arrow.right")
            }
        }
        
        // Icon-only button
        CButton(action: { print("Icon only button") }, color: .pink) {
            Image(systemName: "heart.fill")
                .font(.system(size: 24))
        }
    }
    .padding()
}
