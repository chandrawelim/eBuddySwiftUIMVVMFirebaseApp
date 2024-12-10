//
//  UserDetailView.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 10/12/24.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    let documentID: String
    
    var body: some View {
        VStack(spacing: 16) {
            /// Display profile image
            if let profileImageURL = viewModel.profileImageURL {
                AsyncImage(url: profileImageURL) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            } else {
                Text("No Profile Image")
                    .foregroundColor(.gray)
            }
            
            /// Upload button
            Button("Upload Image") {
                showImagePicker = true
            }
            .buttonStyle(.borderedProminent)
            
            /// Display user details
            if let user = viewModel.user {
                VStack(alignment: .leading, spacing: 8) {
                    Text("UID: \(user.uid ?? "N/A")")
                    Text("Email: \(user.email ?? "N/A")")
                    Text("Phone: \(user.phoneNumber ?? "N/A")")
                    Text("Gender: \(user.gender == .male ? "Male" : "Female")")
                }
                .font(.headline)
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView("Loading...")
                    .padding()
            }
        }
        .onAppear {
            viewModel.loadUserAndProfileImage(documentID: documentID)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .onChange(of: selectedImage) { newImage in
            if let image = newImage, let uid = viewModel.user?.uid {
                viewModel.uploadProfileImage(image: image, userId: uid)
            }
        }
    }
}
