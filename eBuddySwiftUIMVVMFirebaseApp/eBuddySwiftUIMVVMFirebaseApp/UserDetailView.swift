//
//  UserDetailView.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 10/12/24.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject private var viewModel = UserViewModel()
    
    let documentID: String
    
    var body: some View {
        VStack(spacing: 16) {
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
            viewModel.loadUser(documentID: documentID)
        }
    }
}
