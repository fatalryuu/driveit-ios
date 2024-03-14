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
                
                SliderView(car: car)
                
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
        CarDetailsView(car: CarInfo(id: "mHf4LCSAezO97KcNVYGg", name: "Ford Mustang VI", description: "The Ford Mustang VI, introduced in 2015, continues the iconic legacy of the Mustang line with its blend of performance, style, and modern technology. As the sixth generation of this legendary muscle car, the Mustang VI embodies the spirit of American muscle with its powerful engine options, including the robust V8 found in the GT model. Its sleek and aggressive exterior design pays homage to its predecessors while incorporating contemporary elements, making it instantly recognizable on the road. Inside, the Mustang VI offers a refined and driver-focused cockpit, complete with advanced infotainment features and premium materials. Whether you're cruising down the highway or tearing up the track, the Ford Mustang VI delivers an exhilarating driving experience that's sure to leave a lasting impression", images: ["https://firebasestorage.googleapis.com/v0/b/bsuir-mobiles-development.appspot.com/o/ford-mustang.jpg?alt=media&token=9094e789-a5ba-431f-b603-acb3b048be86", "https://firebasestorage.googleapis.com/v0/b/bsuir-mobiles-development.appspot.com/o/12671.jpg?alt=media&token=2260cde2-f05a-4de8-970f-57c858481ddc", "https://firebasestorage.googleapis.com/v0/b/bsuir-mobiles-development.appspot.com/o/Ford-Mustang-VI.jpg?alt=media&token=7b4b9d91-4a80-46fb-87ec-ebd2596e678e",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           "https://firebasestorage.googleapis.com/v0/b/bsuir-mobiles-development.appspot.com/o/Ford_Mustang_V6.jpg?alt=media&token=78ababa4-3207-41b9-b70c-4ae2ed4c7b85",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           "https://firebasestorage.googleapis.com/v0/b/bsuir-mobiles-development.appspot.com/o/cattouch.webp?alt=media&token=e438a12e-6932-4b5c-810c-38b0f72ed0c5"]))
    }
}
