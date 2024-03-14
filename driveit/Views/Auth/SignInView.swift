//
//  SignInView.swift
//  driveit
//
//  Created by Ivan Shatko on 13.03.24.
//

import SwiftUI

struct SignInView: View {
    @Binding var isAuthenticated: Bool
    @State var email: String = ""
    @State var password: String = ""
    @State var formError: String = ""
    @State var isLoading: Bool = false
    
    var isButtonDisabled: Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    func signIn() async {
        do {
            guard password.count >= 8 else {
                formError = "Password should be at least 8 characters long"
                return
            }
            
            isLoading = true
            formError = ""
            
            defer {
                isLoading = false
            }
            
            try await AuthManager.shared.signIn(email: email, password: password)
            isAuthenticated = true
        } catch {
            if (error.localizedDescription.starts(with: "The supplied")) {
                formError = "Invalid email or password"
                return
            }
            formError = error.localizedDescription
            // delte "." at the end
            formError.removeLast()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.95)
                    .ignoresSafeArea(.all)
                VStack {
                    Text("Welcome back")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    
                    Text("Please, enter your credentials")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.bottom, 24)
                    
                    VStack(spacing: 18) {
                        InputView(value: $email, placeholder: "Email")
                        InputView(value: $password, placeholder: "Password", secure: true)
                    }
                    
                    if !formError.isEmpty {
                        ErrorView(text: formError)
                    }
                    
                    ButtonView(action: signIn, text: "Sign In", disabled: isButtonDisabled)
                        .padding(.top, formError.isEmpty ? 28 : 5)
                    
                    NavigationLink(destination: SignUpView(isAuthenticated: $isAuthenticated).navigationBarBackButtonHidden(true)) {
                        Text("Don't have an account?")
                            .foregroundColor(.white)
                            .padding(.top, 12)
                    }
                }
            }
        }
    }
}

#Preview {
    SignInView(isAuthenticated: .constant(false))
}
