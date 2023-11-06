//
//  LoginView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import SwiftUI

struct LoginView: View {
    
    
    @EnvironmentObject var authManager: AuthentificationManager
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24) {
                    InputView(text: $viewModel.email,
                              title: "Email",
                              placeholder: "email@example.com")
                    .textInputAutocapitalization(.none)
                    
                    InputView(text: $viewModel.password,
                              title: "Password",
                              placeholder: "Enter password",
                              isSecure: true
                    )
                    .textInputAutocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    Task {
                        try await authManager.signIn(
                            email: viewModel.email,
                            password: viewModel.password
                        )
                    }
                } label: {
                    HStack {
                        Text("Sign in")
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
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 2) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }

            }
        }
    }
}

extension LoginView: AuthViewModelProtocol {
    var isFormValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
