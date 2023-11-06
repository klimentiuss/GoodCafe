//
//  RegistrationView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthentificationManager
    @StateObject private var viewModel = RegistrationViewModel()

    var body: some View {
        VStack {
            Image("fireBaseLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                InputView(text: $viewModel.email,
                          title: "Email",
                          placeholder: "email@example.com")
                .textInputAutocapitalization(.never)
                
                InputView(text: $viewModel.fullname,
                          title: "Full name",
                          placeholder: "Enter full name"
                          )
                
                InputView(text: $viewModel.password,
                          title: "Password",
                          placeholder: "Enter password",
                          isSecure: true
                )
                .textInputAutocapitalization(.never)
                
                InputView(text: $viewModel.confirmPassword,
                          title: "Confirm password",
                          placeholder: "Enter password",
                          isSecure: true
                )
                .textInputAutocapitalization(.never)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await authManager.createUser(
                        withEmail: viewModel.email,
                        password: viewModel.password,
                        fullname: viewModel.fullname
                    )
                }
            } label: {
                HStack {
                    Text("Sign up")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!isFormValid)
            .opacity(isFormValid ? 1 : 0.5 )
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 2) {
                    Text("Have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }

        }
    }
}

extension RegistrationView: AuthViewModelProtocol {
    var isFormValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 5
        && viewModel.confirmPassword == viewModel.password
        && !viewModel.fullname.isEmpty
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
