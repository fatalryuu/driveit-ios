////
////  SignInView.swift
////  driveit
////
////  Created by Ivan Shatko on 14.02.24.
////
//
//import SwiftUI
//
//@MainActor
//final class AuthFormViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    
//    func singUp() async throws {
//        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
//        try await UserManager.shared.createUser(data: authDataResult)
//    }
//    
//    func singIn() async throws {
//        try await AuthenticationManager.shared.signInUser(email: email, password: password)
//    }
//}
//
//struct AuthFormView: View {
//    @StateObject private var viewModel = AuthFormViewModel()
//    @State var formError: Error? = nil
//    @State var isSignUpForm: Bool = true
//    @Binding var showSignUpView: Bool
//    
//    var body: some View {
//        let isButtonDisabled = viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.password.count < 8
//        
//        VStack {
//            TextField("Email", text: $viewModel.email)
//                .padding()
//                .background(.gray.opacity(0.3))
//                .cornerRadius(10)
//            
//            SecureField("Password", text: $viewModel.password)
//                .padding()
//                .background(.gray.opacity(0.3))
//                .cornerRadius(10)
//            
//            if formError != nil {
//                Text(formError!.localizedDescription)
//                    .font(.subheadline)
//                    .foregroundColor(.red)
//            }
//            
//            Button {
//                Task {
//                    do {
//                        if isSignUpForm {
//                            try await viewModel.singUp()
//                        } else {
//                            try await viewModel.singIn()
//                        }
//                        formError = nil
//                        showSignUpView = false
//                    } catch {
//                        formError = error
//                    }
//                }
//            } label: {
//                Text(isSignUpForm ? "Sign Up" : "Sign In")
//                    .font(.headline)
//                    .frame(height: 55)
//                    .frame(maxWidth: .infinity)
//            }
//            .disabled(isButtonDisabled)
//            .background(isButtonDisabled ? .gray.opacity(0.5) : .blue)
//            .foregroundStyle(isButtonDisabled ? .gray : .white)
//            .cornerRadius(10)
//            
//            
//            Button(action: {
//                isSignUpForm = !isSignUpForm
//                formError = nil
//                viewModel.email = ""
//                viewModel.password = ""
//            }) {
//                Text(isSignUpForm ? "Already have an account?" : "Don't have an account?")
//                    .font(.headline)
//                    .foregroundStyle(.blue)
//                    .padding(.top, 5)
//            }
//
//            Spacer()
//        }
//        .padding()
//        .navigationTitle(isSignUpForm ? "Sign Up" : "Sign In")
//    }
//}
//
//#Preview {
//    NavigationStack {
//        AuthFormView(showSignUpView: .constant(false))
//    }
//}
