//
//  SecureInputView.swift
//  driveit
//
//  Created by Ivan Shatko on 14.03.24.
//

import SwiftUI

struct SecureInputView: View {
    SecureField("", text: $password, prompt: Text("Password").foregroundColor(.white))
        .padding()
        .font(.system(size: 18))
        .frame(width: 0.8 * UIScreen.main.bounds.width)
        .foregroundColor(.white)
        .textInputAutocapitalization(.never)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 2))
}
