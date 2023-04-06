//
//  SwiftUIView.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 06/04/23.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var greeting: String = "Hello!"
    
    var body: some View {
        VStack {
            Text(greeting)
                .font(.largeTitle)
            ExtractedView(greeting: $greeting)
            
        }
        .padding()
    }
}

struct ExtractedView: View {
    @Binding var greeting: String
    
    var body: some View {
        Button("Change greeting", action: {
            greeting = "Aloha!"
        })
        .buttonStyle(.borderedProminent)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
