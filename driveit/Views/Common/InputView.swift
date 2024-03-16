//
//  InputView.swift
//  driveit
//
//  Created by Ivan Shatko on 14.03.24.
//

import SwiftUI

struct InputView: View {
    @Binding var value: String
    var placeholder: String
    var secure: Bool = false
    
    var body: some View {
        if secure {
            SecureField("", text: $value, prompt: Text(placeholder).foregroundColor(.white))
                .padding()
                .font(.system(size: 18))
                .frame(width: 0.8 * UIScreen.main.bounds.width)
                .foregroundColor(.white)
                .textInputAutocapitalization(.never)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 2))
        } else {
            TextField("", text: $value, prompt: Text(placeholder).foregroundColor(.white))
                .padding()
                .font(.system(size: 18))
                .frame(width: 0.8 * UIScreen.main.bounds.width)
                .foregroundColor(.white)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 2))
        }
    }
}
