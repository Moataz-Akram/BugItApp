//
//  ContentView.swift
//  BugItApp
//
//  Created by Moataz Akram on 13/09/2024.
//

import SwiftUI
import BugItPackage

struct ContentView: View {
    @ObservedObject private var bugItManager = BugItManager.shared
    
    var body: some View {
        NavigationView {
            if bugItManager.shouldShowLogin {
                LoginButtonView()
            } else {
                NavigationLink(destination: BugFormView()
                    .navigationBarTitle("Bug Form", displayMode: .inline)) {
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
