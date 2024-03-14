//
//  StorageManager.swift
//  driveit
//
//  Created by Ivan Shatko on 14.03.24.
//

import Foundation
import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
}
