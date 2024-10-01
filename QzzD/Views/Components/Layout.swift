//
//  Layout.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct Layout<Content: ViewContent>: View {
    let content: () -> Content
    let title: String
    
    init(title: String = "", @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack {
            Text("QzzD!")
                .font(.system(size: 56, weight: .black))
                .padding(.vertical, 10)
            Text(title)
                .font(.system(size: 32, weight: .black))
            content()
        }
        .padding()
    }
}

#Preview {
    Layout(title: "Hello, World!") {
        Spacer()
        Text("Hello, Layout!")
    }
}
