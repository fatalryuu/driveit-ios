//
//  CarDetailView.swift
//  driveit
//
//  Created by Ivan Shatko on 3.03.24.
//

import SwiftUI

struct CarDetailsView: View {
    @State var car: CarInfo
    @State var isFavourite = false
    @State var isLoading = false
    
    func handleClick() async {
        do {
            isLoading = true
            
            defer {
                isLoading = false
            }
            
            if (isFavourite) {
                try await CarsManager.shared.removeFromFavourites(id: car.id)
            } else {
                try await CarsManager.shared.addToFavourites(id: car.id)
            }
            
            isFavourite.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.95)
                .ignoresSafeArea(.all)
            VStack {
                Text(car.name)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                if (car.images.count > 0) {
                    SliderView(car: car)
                } else {
                    Text("No photos yet")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                        .padding(.vertical, 20)
                }
                
                Text("Desctiption")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 6)
                
                ScrollView {
                    Text(car.description)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 0.8 * UIScreen.main.bounds.width)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                ButtonView(action: handleClick, text: isFavourite ? "Remove from Favourites" : "Add to Favourites", disabled: isLoading)
                    .padding(.bottom, 30)
            }
        }
        .onAppear() {
            Task {
                isLoading = true
                isFavourite = try await CarsManager.shared.isCarFavourite(id: car.id)
                isLoading = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        CarDetailsView(car: CarInfo(id: "mHf4LCSAezO97KcNVYGg", name: "Ford Mustang VI", description: "The Ford Mustang VI", images: []))
    }
}
