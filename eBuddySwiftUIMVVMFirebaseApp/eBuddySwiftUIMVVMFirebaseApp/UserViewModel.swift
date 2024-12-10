//
//  UserViewModel.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 10/12/24.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: UserJSON?
    @Published var errorMessage: String?
    
    private let firebaseService: FirebaseServiceProtocol
    
    init(firebaseService: FirebaseServiceProtocol = FirebaseService()) {
        self.firebaseService = firebaseService
    }
    
    func loadUser(documentID: String) {
        firebaseService.fetchUser(with: documentID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

