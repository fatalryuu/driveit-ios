//
//  CarsListView.swift
//  driveit
//
//  Created by Ivan Shatko on 17.02.24.
//

import SwiftUI

struct CarsListView: View {
    @State var cars: [CarInfo] = []
    @State private var search: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Cars list")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 64)
                    
                    TextField("", text: $search, prompt: Text("Search...").foregroundColor(.white))
                        .padding(10)
                        .font(.system(size: 18))
                        .frame(width: 0.9 * UIScreen.main.bounds.width)
                        .foregroundColor(.white)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white, lineWidth: 2))
                        .padding(.bottom, 24)
                    
                    ForEach(getFilteredCars(cars: cars)) { car in
                        CarItemView(car: car)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 100)
            }
            .background(Color.black.opacity(0.95))
            .ignoresSafeArea(.all)
            .onAppear() {
                Task {
                    do {
                        cars = try await CarsManager.shared.getCars()
                    }
                }
            }
        }
    }
    
    func getFilteredCars(cars: [CarInfo]) -> [CarInfo] {
        guard !search.isEmpty else {
            
            return cars
        }
        
        return cars.filter { car in
            car.name.lowercased().contains(search.lowercased())
        }
    }
}

#Preview {
    NavigationStack {
        CarsListView()
    }
}
