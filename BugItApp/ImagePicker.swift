//
//  ImagePicker.swift
//  BugItApp
//
//  Created by Moataz Akram on 13/09/2024.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: image)
            }
//            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
    }
}

