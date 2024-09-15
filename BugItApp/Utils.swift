//
//  Utils.swift
//  BugItApp
//
//  Created by Moataz Akram on 16/09/2024.
//

import SwiftUI

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
    }
}

extension UIApplication {
    func hideKeyboard() {
        guard let window = connectedScenes
                .flatMap({ ($0 as? UIWindowScene)?.windows ?? [] })
                .first(where: { $0.isKeyWindow }) else { return }
        window.endEditing(true)
    }
}

