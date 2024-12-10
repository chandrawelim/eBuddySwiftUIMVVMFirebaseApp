//
//  UserJSON.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 10/12/24.
//

import Foundation

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}

struct UserJSON: Codable {
    let uid: String?
    let email: String?
    let phoneNumber: String?
    let gender: GenderEnum?
}

