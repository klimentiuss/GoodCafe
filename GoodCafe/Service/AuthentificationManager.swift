//
//  RegistrationViewModel.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


protocol AuthViewModelProtocol {
    var isFormValid: Bool { get }
}

@MainActor
class AuthentificationManager: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentuser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Error login: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentuser = nil
        } catch {
            print("Error signout: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentuser = try? snapshot.data(as: User.self)
        print("USER: \(String(describing: self.currentuser))")
    }
}
