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
    
    init(title: String = "", showBackButton: Bool = true, isMainMenu: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.showBackButton = showBackButton
        self.isMainMenu = isMainMenu
        self.content = content
    }
    
    var body: some View {
        VStack {
            Text("QzzD!")
                .font(.system(size: isMainMenu ? 100 : 56, weight: .black))
                .padding(.vertical, 10)
            Text(title)
                .font(.system(size: 32, weight: .black))
            content()
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading: backButton)
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
