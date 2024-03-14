//
//  ProfileView.swift
//  driveit
//
//  Created by Ivan Shatko on 14.03.24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isAuthenticated: Bool
    @State var userInfo: UserInfo = UserInfo(id: "", email: "")
    @State var isEditing: Bool = false
    @State var isLoading: Bool = false
    @State var pageError: String = ""
    
    func editProfile() async {
        if (isEditing) {
            do {
                isLoading = true
                
                defer {
                    isLoading = false
                }
                
                guard let newUserData = try await UsersManager.shared.updateUser(data: userInfo) else {
                    pageError = "Error while updating profile"
                    return
                }
                
                userInfo = newUserData
            } catch {
                pageError = error.localizedDescription
                pageError.removeLast()
            }
        }
        isEditing.toggle()
    }
    
    func logOut() {
        do {
            try AuthManager.shared.logOut()
            isAuthenticated = false
        } catch {
            pageError = error.localizedDescription
            pageError.removeLast()
        }
    }
    
    func deleteAccount() async {
        do {
            try await AuthManager.shared.deleteUserAuth()
            try await UsersManager.shared.deleteUserDB(id: userInfo.id)
            isAuthenticated = false
        } catch {
            pageError = error.localizedDescription
            pageError.removeLast()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Profile")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 12)
                    .padding(.top, 64)
                
                Text(userInfo.email)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 18)
                
                ProfileInputView(value: $userInfo.name, placeholder: "Name", isEditing: isEditing)
                ProfileInputView(value: $userInfo.surname, placeholder: "Surname", isEditing: isEditing)
                ProfileInputView(value: $userInfo.username, placeholder: "Username", isEditing: isEditing)
                ProfileInputView(value: $userInfo.birthday, placeholder: "Birthday", isEditing: isEditing)
                ProfileInputView(value: $userInfo.job, placeholder: "Job", isEditing: isEditing)
                ProfileInputView(value: $userInfo.country, placeholder: "Country", isEditing: isEditing)
                ProfileInputView(value: $userInfo.city, placeholder: "City", isEditing: isEditing)
                ProfileInputView(value: $userInfo.education, placeholder: "Education", isEditing: isEditing)
                ProfileInputView(value: $userInfo.hobby, placeholder: "Hobby", isEditing: isEditing)
                ProfileInputView(value: $userInfo.social, placeholder: "Social", isEditing: isEditing)
                
                ErrorView(text: pageError)
                
                ButtonView(action: editProfile, text: isEditing ? "Save changes" : "Edit profile", disabled: isLoading, color: Color.pink)
                    .padding(.top, pageError.isEmpty ? 0 : 14)
                
                ButtonView(action: logOut, text: "Logout", disabled: isLoading, color: Color.pink)
                    .padding(.top, 6)
                
                ButtonView(action: deleteAccount, text: "Delete account", disabled: isLoading, color: Color(red: 0.78, green: 0, blue: 0.16, opacity: 1))
                    .padding(.top, 24)
                    .padding(.bottom, 100)
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color.black.opacity(0.95))
        .ignoresSafeArea(.all)
        .onAppear {
            fetchUserInfo()
        }
    }
    
    private func fetchUserInfo() {
        if let authUser = AuthManager.shared.getAuthenticatedUser() {
            Task {
                do {
                    guard let user = try await UsersManager.shared.getUser(id: authUser.id) else {
                        pageError = "Error while getting profile info"
                        return
                    }
                    
                    userInfo = user
                } catch {
                    pageError = error.localizedDescription
                    pageError.removeLast()
                }
            }
        }
    }
}

#Preview {
    ProfileView(isAuthenticated: .constant(true))
}
