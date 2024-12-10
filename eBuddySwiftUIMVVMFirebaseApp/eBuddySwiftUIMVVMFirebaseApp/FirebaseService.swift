//
//  FirebaseService.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 10/12/24.
//

import FirebaseFirestore

protocol FirebaseServiceProtocol {
    func fetchUser(with documentID: String, completion: @escaping (Result<UserJSON, Error>) -> Void)
}

final class FirebaseService: FirebaseServiceProtocol {
    private let db = Firestore.firestore()
    
    func fetchUser(with documentID: String, completion: @escaping (Result<UserJSON, Error>) -> Void) {
        db.collection("USERS").document(documentID).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = try? snapshot?.data(as: UserJSON.self) else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
    }
}
