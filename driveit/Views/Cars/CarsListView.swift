//
//  CarsListView.swift
//  driveit
//
//  Created by Ivan Shatko on 17.02.24.
//

import SwiftUI

struct CarsListView: View {
    @State var cars: [CarInfo] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Cars list")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 24)
                        .padding(.top, 64)
                    
                    ForEach(cars) { car in
                        CarItemView(car: car)
                    }
                }
                .frame(maxWidth: .infinity)
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
}

#Preview {
    NavigationStack {
        CarsListView()
    }
}
