//
//  FirebaseConfig.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 09/12/24.
//

import FirebaseCore

enum FirebaseEnvironment {
    case development
    case staging
}

class FirebaseConfig {
    static func configure(for environment: FirebaseEnvironment) {
        let fileName: String
        switch environment {
        case .development:
            fileName = "GoogleService-Info-Development"
        case .staging:
            fileName = "GoogleService-Info-Staging"
        }
        
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "plist"),
              let options = FirebaseOptions(contentsOfFile: filePath) else {
            fatalError("Invalid Firebase configuration file.")
        }

        FirebaseApp.configure(options: options)
    }
}

