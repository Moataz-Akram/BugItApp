//
//  BugFormView.swift
//  BugItApp
//
//  Created by Moataz Akram on 13/09/2024.
//

import SwiftUI

struct BugFormView: View {
    @State private var bugTitle: String = ""
    @State private var bugDescription: String = ""
    @State private var selectedImage: Image? = nil
    @State private var submitButtonEnabled: Bool = false

    var body: some View {
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
                    //TODO: add image picker
                } label: {
                    Text("Add Image")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 60)

                Button {
                    // TODO: submit bug, if succeeded, navigate back
                } label: {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(submitButtonEnabled ? Color.green : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(submitButtonEnabled)
            }
            .padding(.top, 16)
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
    }
    
}

#Preview {
    BugFormView()
}
