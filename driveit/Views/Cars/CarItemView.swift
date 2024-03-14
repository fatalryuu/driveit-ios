//
//  CarItemView.swift
//  driveit
//
//  Created by Ivan Shatko on 14.03.24.
//

import SwiftUI

struct CarItemView: View {
    @State var car: CarInfo

    var body: some View {
        NavigationLink(destination: CarDetailsView(car: car).toolbarRole(.editor)) {
            VStack {
                Text(car.name)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 200)
            }
            .background(Color.pink)
            .cornerRadius(16)
            .frame(width: 0.9 * UIScreen.main.bounds.width)
            .padding(.bottom)
        }
    }
}

#Preview {
    NavigationStack {
        CarItemView(car: CarInfo(id: "1", name: "Ford Mustang VI", description: "hello", images: []))
    }
}
