//
//  ContentView.swift
//  BugItApp
//
//  Created by Moataz Akram on 13/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: 
                                BugFormView()
                                    .navigationBarTitle("Bug Form", displayMode: .inline)
                ) {
                    Text("Report a bug")
                }
                .buttonStyle(.bordered)
            }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
}
