//
//  UserViewModel.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 10/12/24.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: UserJSON?
    @Published var profileImageURL: URL?
    @Published var errorMessage: String?
    
    private let firebaseService: FirebaseServiceProtocol
    
    init(firebaseService: FirebaseServiceProtocol = FirebaseService()) {
        self.firebaseService = firebaseService
    }
    
    func loadUserAndProfileImage(documentID: String) {
        loadUser(documentID: documentID)
        if let uid = user?.uid {
            loadProfileImage(userId: uid)
        }
    }
    
    private func loadUser(documentID: String) {
        firebaseService.fetchUser(with: documentID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user
                    if let uid = user.uid {
                        self?.loadProfileImage(userId: uid)
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func loadProfileImage(userId: String) {
        firebaseService.fetchProfileImageURL(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let url):
                    self?.profileImageURL = url
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func uploadProfileImage(image: UIImage, userId: String) {
        firebaseService.uploadProfileImage(image: image, userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.loadProfileImage(userId: userId)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

extension UserViewModel {
    func fetchFilteredUsers() {
        firebaseService.fetchUsersWithFilters { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    print("Fetched Users: \(users)")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
