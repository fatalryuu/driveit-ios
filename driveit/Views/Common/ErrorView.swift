//
//  ErrorView.swift
//  driveit
//
//  Created by Ivan Shatko on 14.03.24.
//

import SwiftUI

struct ErrorView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.red)
            .padding(.top, 12)
            .frame(width: 0.9 * UIScreen.main.bounds.width)
    }
}
