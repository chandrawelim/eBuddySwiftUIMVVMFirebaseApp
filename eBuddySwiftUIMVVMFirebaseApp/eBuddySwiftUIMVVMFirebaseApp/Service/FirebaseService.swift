//
//  FirebaseService.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 10/12/24.
//

import FirebaseFirestore
import FirebaseStorage

protocol FirebaseServiceProtocol {
    func fetchUser(with documentID: String, completion: @escaping (Result<UserJSON, Error>) -> Void)
    func uploadProfileImage(image: UIImage, userId: String, completion: @escaping (Result<URL, Error>) -> Void)
    func fetchProfileImageURL(userId: String, completion: @escaping (Result<URL, Error>) -> Void)
    func fetchUsersWithFilters(completion: @escaping (Result<[UserJSON], Error>) -> Void)
}

final class FirebaseService: FirebaseServiceProtocol {
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
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
    
    /// Uploads an image to Firebase Storage
    func uploadProfileImage(image: UIImage, userId: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data."])))
            return
        }
        
        let storageRef = storage.reference().child("profile_images/\(userId).jpg")
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                }
            }
        }
    }
    
    /// Fetches the profile image URL
    func fetchProfileImageURL(userId: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let storageRef = storage.reference().child("profile_images/\(userId).jpg")
        storageRef.downloadURL { url, error in
            if let error = error {
                completion(.failure(error))
            } else if let url = url {
                completion(.success(url))
            }
        }
    }
}

extension FirebaseService {
    func fetchUsersWithFilters(completion: @escaping (Result<[UserJSON], Error>) -> Void) {
        db.collection("USERS")
            .whereField("gender", isEqualTo: GenderEnum.female.rawValue)
            .order(by: "recentlyActive", descending: true)
            .order(by: "rating", descending: true)
            .order(by: "servicePricing", descending: false)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                    return
                }
                
                let users = documents.compactMap { try? $0.data(as: UserJSON.self) }
                completion(.success(users))
            }
    }
}
