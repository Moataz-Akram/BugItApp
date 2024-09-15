//
//  BugFormView.swift
//  BugItApp
//
//  Created by Moataz Akram on 13/09/2024.
//

import SwiftUI
import BugItPackage

struct BugFormView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var bugTitle: String = ""
    @State private var bugDescription: String = ""
    @State private var selectedImage: Image? = nil
    @State private var isImagePickerPresented = false
    @State private var selectedUIImage: UIImage? = nil
    @State private var isLoading = false
    @State private var showErrorAlert = false
    private var submitButtonEnabled: Bool {
        !bugTitle.isEmpty && selectedImage != nil
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    TextField("Bug Title", text: $bugTitle)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    TextEditor(text: $bugDescription)
                        .frame(height: 150)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    HStack {
                        Spacer()
                        if let image = selectedImage {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 200)
                                .overlay(
                                    Text("No image selected")
                                        .foregroundColor(.gray)
                                )
                                .cornerRadius(10)
                            
                        }
                        Spacer()
                    }
                    .cornerRadius(10)
                    .padding(.vertical)
                    
                    Button {
                        isImagePickerPresented = true
                    } label: {
                        Text("Add Image")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 50)
                    .sheet(isPresented: $isImagePickerPresented, onDismiss: nil) {
                        ImagePicker(image: $selectedImage, uiImage: $selectedUIImage)
                    }
                    
                    
                    Button {
                        isLoading = true
                        Task {
                            do {
                                try await BugItManager.shared.uploadBug(bug: Bug(title: bugTitle, description: bugDescription, image: selectedUIImage ?? UIImage()))
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                showErrorAlert = true
                            }
                            isLoading = false
                        }
                    } label: {
                        Text("Submit")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(submitButtonEnabled ? Color.green : Color.gray)
                            .cornerRadius(10)
                    }
                    .disabled(!submitButtonEnabled)
                }
                .padding(.top, 16)
                .opacity(isLoading ? 0.4 : 1)
            }
            .alert("Alert Title", isPresented: $showErrorAlert) {
                Button("OK") {
                    showErrorAlert = false
                }
                .tint(.black)
            } message: {
                Text("An error happened while uploading the bug, please try again later.")
            }
            if isLoading {
                VStack {
                    Spacer()
                    ProgressView("Submitting...")
                        .padding(.all, 20)
                        .progressViewStyle(CircularProgressViewStyle())
                        .background(Color.gray.opacity(0.6))
                        .cornerRadius(10)
                    Spacer()
                }
                .zIndex(5)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .disabled(isLoading)
    }
    
}

#Preview {
    BugFormView()
}
