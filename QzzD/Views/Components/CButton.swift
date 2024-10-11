//
//  CButton.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct CButton<Content: View>: View {
    let action: (() -> Void)?
    let destination: AnyView?
    let color: Color
    let fullWidth: Bool
    let content: () -> Content
    
    init(action: (() -> Void)? = nil, color: Color = .blue, fullWidth: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.destination = nil
        self.color = color
        self.fullWidth = fullWidth
        self.content = content
    }
    
    init<Destination: View>(destination: @escaping () -> Destination, color: Color = .blue, fullWidth: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.action = nil
        self.destination = AnyView(destination())
        self.color = color
        self.fullWidth = fullWidth
        self.content = content
    }
    
    var body: some View {
        Group {
            if let destination = destination {
                NavigationLink(destination: destination) {
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
            CButton(destination: { Text("Destination View") }, color: .indigo) {
                Text("Navigate to Destination")
            }
            
            // Full width button
            CButton(action: { print("Full width button") }, fullWidth: true) {
                Text("Full Width Button")
            }
            
            // Full width colored button with Navigation
            CButton(destination: { Text("Settings View") }, color: .teal, fullWidth: true) {
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
            CButton(destination: { Text("Profile View") }) {
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
