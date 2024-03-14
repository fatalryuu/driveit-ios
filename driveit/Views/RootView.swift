//
//  RootView.swift
//  driveit
//
//  Created by Ivan Shatko on 16.02.24.
//

import SwiftUI

struct RootView: View {
    @State var isAuthenticated: Bool = false
    
    var body: some View {
        if isAuthenticated {
            TabView {
                ProfileView(isAuthenticated: $isAuthenticated)
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Profile")
                    }
                CarsListView()
                    .tabItem {
                        Image(systemName: "car.fill")
                        Text("Cars")
                    }
                FavouritesView()
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Favourites")
                    }
            }
            .accentColor(.pink)
            .onAppear() {
                UITabBar.appearance().barTintColor = .black
            }
        } else {
            SignInView(isAuthenticated: $isAuthenticated)
                .onAppear {
                    if AuthManager.shared.getAuthenticatedUser() != nil {
                        isAuthenticated = true
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
