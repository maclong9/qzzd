//
//  Layout.swift
//  QzzD
//
//  Created by Mac Long on 30/09/2024.
//

import SwiftUI

struct Layout<Content: ViewContent>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            Text("QzzD!")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.top, 10)
            Spacer().frame(height: 50)
            content()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    Layout {
        Text("Hello, Layout!")
    }
}
