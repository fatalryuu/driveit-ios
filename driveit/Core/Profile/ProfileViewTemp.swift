////
////  ProfileView.swift
////  driveit
////
////  Created by Ivan Shatko on 17.02.24.
////
//
//import SwiftUI
//
//@MainActor
//final class ProfileViewModel: ObservableObject {
//    @Published private(set) var user: DBUser? = nil
//    
//    func getUserInfo() async throws {
//        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
//    }
//    
//    func signOut() throws {
//        try AuthenticationManager.shared.signOut()
//    }
//    
//    func deleteAccount() async throws {
//        try await AuthenticationManager.shared.deleteUser()
//        try await UserManager.shared.deleteUserFromDB(userId: user!.userId)
//    }
//    
//    func updateUserInfo(updatedUser: DBUser) async throws -> DBUser {
//        let updatedUser = try await UserManager.shared.updateUser(userId: user!.userId, updatedUser: updatedUser)
//        self.user = updatedUser
//        return updatedUser;
//    }
//}
//
//struct ProfileView: View {
//    @StateObject private var viewModel = ProfileViewModel()
//    @Binding var showSignInView: Bool
//    @State private var isEditing = false
//    @State private var updatedUser = DBUser(user: [:])
//    @State private var deleteError = false
//    
//    var body: some View {
//        List {
//            Section {
//                if let user = viewModel.user {
//                    Text("Email: \(user.email)")
//                    TextField("First name", text: $updatedUser.name)
//                        .disabled(!isEditing)
//                    TextField("Last name", text: $updatedUser.surname)
//                        .disabled(!isEditing)
//                    TextField("Username", text: $updatedUser.username)
//                        .disabled(!isEditing)
//                    TextField("Job", text: $updatedUser.job)
//                        .disabled(!isEditing)
//                    TextField("Birthday", text: $updatedUser.birthday)
//                        .disabled(!isEditing)
//                    TextField("Phone number", text: $updatedUser.phoneNumber)
//                        .disabled(!isEditing)
//                    TextField("Country", text: $updatedUser.country)
//                        .disabled(!isEditing)
//                    TextField("City", text: $updatedUser.city)
//                        .disabled(!isEditing)
//                    TextField("Education", text: $updatedUser.education)
//                        .disabled(!isEditing)
//                    TextField("Social media", text: $updatedUser.socialMedia)
//                        .disabled(!isEditing)
//                }
//                
//                if isEditing {
//                    Button("Save") {
//                        Task {
//                            do {
//                                let updatedUserFromDB = try await viewModel.updateUserInfo(updatedUser: updatedUser)
//                                updatedUser = updatedUserFromDB;
//                                isEditing = false
//                            } catch {
//                                print(error)
//                            }
//                        }
//                    }
//                } else {
//                    Button("Edit") {
//                        isEditing = true
//                        updatedUser = viewModel.user ?? DBUser(user: [:])
//                    }
//                }
//            }
//            
//            Section(footer: ErrorSection(deleteError: deleteError)) {
//                Button("Log out") {
//                    do {
//                        try viewModel.signOut()
//                        showSignInView = true
//                    } catch {
//                        print(error)
//                    }
//                }
//                
//                Button(role: .destructive) {
//                    Task {
//                        do {
//                            try await viewModel.deleteAccount()
//                            showSignInView = true
//                        } catch {
//                            deleteError = true
//                        }
//                    }
//                } label: {
//                    Text("Delete account")
//                }
//            }
//        }
//        .task {
//            try? await viewModel.getUserInfo()
//            updatedUser = viewModel.user != nil ? viewModel.user! : DBUser(user: [:])
//        }
//    }
//}
//
//struct ErrorSection: View {
//    let deleteError: Bool
//    
//    var body: some View {
//        if deleteError {
//            Text("Re-login in account to delete it")
//                .font(.subheadline)
//                .foregroundColor(.red)
//        }
//    }
//}
//
//#Preview {
//    ProfileView(showSignInView: .constant(false))
//}
//
