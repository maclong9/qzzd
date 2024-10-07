//
//  Layout.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct Layout<Content: View>: View {
    let content: () -> Content
    let title: String
    let showBackButton: Bool
    let isMainMenu: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @State private var scale: CGFloat = 0.01
    @State private var opacity: Double = 0
    @State private var size: CGFloat = 0
    @State private var rotation: Double = 0
    @State private var timer: Timer? // Change here to @State
    
    init(title: String = "", showBackButton: Bool = true, isMainMenu: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.showBackButton = showBackButton
        self.isMainMenu = isMainMenu
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if isMainMenu {
                Text("QzzD!")
                    .font(.system(size: 100, weight: .black))
                    .padding(.vertical, 10)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .frame(height: size)
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        withAnimation(.bouncy(duration: 0.6)) {
                            scale = 1
                            opacity = 1
                            size = UIScreen.main.bounds.width
                        }
                        startShaking()
                    }
                    .onDisappear {
                        timer?.invalidate()
                    }
            } else {
                Text("QzzD!")
                    .font(.system(size: 56, weight: .black))
                    .padding(.top, 40)
                    .padding(.bottom, 10)
            }
            
            Text(title)
                .font(.system(size: 32, weight: .black))
                .padding(.bottom, 20)
            
            content()
        }
        .padding(.horizontal)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading: backButton)
    }
    
    private func startShaking() {
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 10...20)), repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                rotation += 5
            }
            withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
                rotation -= 10
            }
            withAnimation(.easeInOut(duration: 0.5).delay(1.0)) {
                rotation += 5
            }
        }
    }
    
    @ViewBuilder
    private var backButton: some View {
        if showBackButton {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    Layout(title: "Hello, world!") {
        Text("Hello, world!")
    }
}

#Preview("Main Menu") {
    Layout(title: "Hello, world!", isMainMenu: true) {
        Text("Hello, world!")
    }
}
