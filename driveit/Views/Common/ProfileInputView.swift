//
//  ProfileInputView.swift
//  driveit
//
//  Created by Ivan Shatko on 14.03.24.
//

import SwiftUI

struct ProfileInputView: View {
    @Binding var value: String
    var placeholder: String
    var isEditing: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(placeholder) ").foregroundColor(.white).font(.system(size: 18)).padding(0)
            TextField("", text: $value, prompt: Text(isEditing ? "Enter..." : "No data").foregroundColor(value.isEmpty ? .gray : .white))
                    .padding(10)
                    .font(.system(size: 18))
                    .frame(width: 0.8 * UIScreen.main.bounds.width)
                    .foregroundColor(.white)
                    .textInputAutocapitalization(.never)
                    .disabled(!isEditing)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isEditing ? .white : .gray, lineWidth: 2))
                    .padding(.bottom, 10)
    
        }
    }
}
