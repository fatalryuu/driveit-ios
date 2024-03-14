//
//  AuthenticationManager.swift
//  driveit
//
//  Created by Ivan Shatko on 14.02.24.
//

import Foundation
import FirebaseAuth

struct UserAuthData {
    let id: String
    let email: String
}

class AuthManager {
    static let shared = AuthManager()
    
    func getAuthenticatedUser() -> UserAuthData? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return UserAuthData(id: user.uid, email: user.email!)
    }
    
    func createUser(email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await UsersManager.shared.createUser(data: UserAuthData(id: result.user.uid, email: result.user.email!))
        try await self.signIn(email: email, password: password);
    }
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteUserAuth() async throws {
        try await Auth.auth().currentUser!.delete()
    }
}
