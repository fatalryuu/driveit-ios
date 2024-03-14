//
//  FavouriteView.swift
//  driveit
//
//  Created by Ivan Shatko on 17.02.24.
//

import SwiftUI

struct FavouritesView: View {
    @State var favourites: [CarInfo] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Favourites")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 24)
                        .padding(.top, 64)
                    
                    if favourites.count > 0 {
                        ForEach(favourites) { car in
                            CarItemView(car: car)
                        }
                    } else {
                        Text("No data   :(")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        
                        Text("You can add some on the \"Cars\" tab")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.bottom, 24)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.black.opacity(0.95))
            .ignoresSafeArea(.all)
            .onAppear() {
                Task {
                    do {
                        favourites = try await CarsManager.shared.getFavourites()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavouritesView()
    }
}
