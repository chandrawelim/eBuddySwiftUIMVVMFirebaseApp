//
//  eBuddySwiftUIMVVMFirebaseAppApp.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 09/12/24.
//

import SwiftUI
import Firebase

@main
struct eBuddySwiftUIMVVMFirebaseAppApp: App {
    
    init() {
         #if DEBUG
         FirebaseConfig.configure(for: .development)
         #else
         FirebaseConfig.configure(for: .staging)
         #endif
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
