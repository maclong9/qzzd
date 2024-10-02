//
//  CButton.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct CButton<Content: View, Destination: View>: View {
    let action: (() -> Void)?
    let link: (() -> Destination)?
    let color: Color
    let fullWidth: Bool
    let content: () -> Content
    
    init(action: (() -> Void)? = nil, color: Color = .blue, fullWidth: Bool = false, @ViewBuilder content: @escaping () -> Content) where Destination == Never {
        self.action = action
        self.link = nil
        self.color = color
        self.fullWidth = fullWidth
        self.content = content
    }
    
    init(link: @escaping () -> Destination, color: Color = .blue, fullWidth: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.action = nil
        self.link = link
        self.color = color
        self.fullWidth = fullWidth
        self.content = content
    }
    
    var body: some View {
        Group {
            if let link = link {
                NavigationLink(destination: link()) {
                    buttonContent
                }
            } else {
                Button(action: { action?() }) {
                    buttonContent
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var buttonContent: some View {
        content()
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .fontWeight(.bold)
    }
}

#Preview {
    NavigationView {
        VStack(spacing: 20) {
            // Default Button
            CButton(action: { print("Default button") }) {
                Text("Default Button")
            }
            
            // Colored Button with Navigation
            CButton(link: { Text("Destination View") }, color: .indigo) {
                Text("Navigate to Destination")
            }
            
            // Full width button
            CButton(action: { print("Full width button") }, fullWidth: true) {
                Text("Full Width Button")
            }
            
            // Full width colored button with Navigation
            CButton(link: { Text("Settings View") }, color: .teal, fullWidth: true) {
                Text("Go to Settings")
            }
            
            // Button with left icon
            CButton(action: { print("Left icon button") }) {
                HStack {
                    Image(systemName: "star.fill")
                    Text("Favorite")
                }
            }
            
            // Button with right icon and Navigation
            CButton(link: { Text("Profile View") }) {
                HStack {
                    Text("Profile")
                    Image(systemName: "person.fill")
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
}
