//
//  CarsManager.swift
//  driveit
//
//  Created by Ivan Shatko on 3.03.24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CarInfo: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let images: [String]
}

class CarsManager {
    static let shared = CarsManager()
    
    func getCars() async throws -> [CarInfo] {
        var cars: [CarInfo] = []
        
        let querySnapshot = try await Firestore.firestore().collection("cars").getDocuments()
        for document in querySnapshot.documents {
            if let car = try? document.data(as: CarInfo.self) {
                cars.append(car)
            }
        }
        
        return cars
    }
    
    func getCar(id: String) async throws -> CarInfo? {
        let document = try await Firestore.firestore().collection("cars").document(id).getDocument()
        return try document.data(as: CarInfo.self)
    }
    
    func getFavourites() async throws -> [CarInfo] {
        var favourites: [CarInfo] = []
        let userAuth = AuthManager.shared.getAuthenticatedUser()
        if userAuth != nil {
            let userInfo = try await UsersManager.shared.getUser(id: userAuth!.id)
            
            for favourite in userInfo!.favourites {
                favourites.append(try await favourite.getDocument().data(as: CarInfo.self))
            }
            
            return favourites
        }
        
        return []
    }
    
    func isCarFavourite(id: String) async throws -> Bool {
        let favourites = try await self.getFavourites()
        
        for favourite in favourites {
            if (favourite.id == id) {
                return true
            }
        }
        return false
    }
    
    func addToFavourites(id: String) async throws {
        let userAuth = AuthManager.shared.getAuthenticatedUser()
        let userInfo = try await UsersManager.shared.getUser(id: userAuth!.id)
        
        let carRef = Firestore.firestore().collection("cars").document(id)
        var newFavourites = userInfo!.favourites
        newFavourites.append(carRef)
        try await UsersManager.shared.updateUserFavourites(id: userAuth!.id, favourites: newFavourites)
    }
    
    func removeFromFavourites(id: String) async throws {
        let userAuth = AuthManager.shared.getAuthenticatedUser()
        let userInfo = try await UsersManager.shared.getUser(id: userAuth!.id)
        
        let carRef = Firestore.firestore().collection("cars").document(id)
        var newFavourites = userInfo!.favourites
        newFavourites.removeAll { $0.documentID == carRef.documentID }
        try await UsersManager.shared.updateUserFavourites(id: userAuth!.id, favourites: newFavourites)
    }
}
