//
//  SignUpView.swift
//  driveit
//
//  Created by Ivan Shatko on 14.03.24.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isAuthenticated: Bool
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    @State var formError: String = ""
    @State var isLoading: Bool = false
    
    var isButtonDisabled: Bool {
        return email.isEmpty || password.isEmpty || repeatPassword.isEmpty || isLoading
    }
    
    func signUp() async {
        do {
            guard password.count >= 8 && repeatPassword.count >= 8 else {
                formError = "Password should be at least 8 characters long"
                return
            }
            
            guard password == repeatPassword else {
                formError = "Passwords should match"
                return
            }
            
            isLoading = true
            formError = ""
            
            defer {
                isLoading = false
            }
            
            try await AuthManager.shared.createUser(email: email, password: password)
            isAuthenticated = true
        } catch {
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
                    Text("Create a new account")
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
                        InputView(value: $repeatPassword, placeholder: "Repeat password", secure: true)
                    }
                    
                    if !formError.isEmpty {
                        ErrorView(text: formError)
                    }
                    
                    ButtonView(action: signUp, text: "Create an account", disabled: isButtonDisabled)
                        .padding(.top, formError.isEmpty ? 28 : 5)
                    
                    NavigationLink(destination: SignInView(isAuthenticated: $isAuthenticated).navigationBarBackButtonHidden(true)) {
                        Text("Already have an account?")
                            .foregroundColor(.white)
                            .padding(.top, 12)
                    }
                }
            }
        }
    }
}

#Preview {
    SignUpView(isAuthenticated: .constant(false))
}

