//
//  UsersManager.swift
//  driveit
//
//  Created by Ivan Shatko on 17.02.24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserInfo {
    let id: String
    let email: String
    var name: String = ""
    var surname: String = ""
    var username: String = ""
    var birthday: String = ""
    var job: String = ""
    var country: String = ""
    var city: String = ""
    var education: String = ""
    var hobby: String = ""
    var social: String = ""
    var favourites: [DocumentReference] = []
}

class UsersManager {
    static let shared = UsersManager()
    private init() {}
    
    func createUser(data: UserAuthData) async throws {
        let userData = [
            "id": data.id,
            "email": data.email,
        ]
        try await Firestore.firestore().collection("users").document(data.id).setData(userData)
    }
    
    func getUser(id: String) async throws -> UserInfo? {
        let snapshot = try await Firestore.firestore().collection("users").document(id).getDocument()
        
        guard let data = snapshot.data() else {
            return nil
        }
        
        return UserInfo(
            id: snapshot.documentID,
            email: data["email"] as! String,
            name: data["name"] as? String ?? "",
            surname: data["surname"] as? String ?? "",
            username: data["username"] as? String ?? "",
            birthday: data["birthday"] as? String ?? "",
            job: data["job"] as? String ?? "",
            country: data["country"] as? String ?? "",
            city: data["city"] as? String ?? "",
            education: data["education"] as? String ?? "",
            hobby: data["hobby"] as? String ?? "",
            social: data["social"] as? String ?? "",
            favourites: data["favourites"] as? [DocumentReference] ?? []
        )
    }
    
    func updateUser(data: UserInfo) async throws -> UserInfo? {
        var userData: [String: Any] = [:]
        let mirror = Mirror(reflecting: data)
        for child in mirror.children {
            if let label = child.label {
                userData[label] = child.value
            }
        }
        try await Firestore.firestore().collection("users").document(data.id).updateData(userData)
        return try await getUser(id: data.id)
    }
    
    func updateUserFavourites(id: String, favourites: [DocumentReference]) async throws {
        try await Firestore.firestore().collection("users").document(id).updateData(["favourites": favourites])
    }
    
    func deleteUserDB(id: String) async throws {
        try await Firestore.firestore().collection("users").document(id).delete()
    }
}
