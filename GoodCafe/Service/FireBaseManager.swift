//
//  RegistrationViewModel.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


protocol FireBaseManagerProtocol {
    var isFormValid: Bool { get }
}

@MainActor
class FireBaseManager: ObservableObject {
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
            
            let user = User(id: result.user.uid, fullname: fullname, email: email, favorites: [])
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
    
    
    func addStringToFavorites(favoriteString: String) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        let userDocument = db.collection("users").document(uid)
        
        do {
            let documentSnapshot = try await userDocument.getDocument()
            var currentFavorites = [String]()
            
            if let documentData = documentSnapshot.data(), let favorites = documentData["favorites"] as? [String] {
                currentFavorites = favorites
            }
            
            if currentFavorites.contains(favoriteString) {
                currentFavorites = currentFavorites.filter { $0 != favoriteString}
            } else {
                currentFavorites.append(favoriteString)
            }
            
            try await userDocument.updateData(["favorites": currentFavorites])
            
            print("Строка успешно добавлена в favorites.")
        } catch {
            print("Ошибка Firestore: \(error.localizedDescription)")
        }
    }
    
    
    func areFavoritesEqual(favoritesToCompare: String) async -> Bool {
        if let uid = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            
            let userDocument = db.collection("users").document(uid)
            
            do {
                let documentSnapshot = try await userDocument.getDocument()
                
                if let documentData = documentSnapshot.data(), let favorites = documentData["favorites"] as? [String] {
                    if favorites.contains(favoritesToCompare) {
                        return true
                    }
                } else {
                    return false
                }
            } catch {
                print("Ошибка Firestore: \(error.localizedDescription)")
                return false
            }
        }
        return false
    }
    
    func getFavorites() async -> [String] {
        if let uid = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            
            let userDocument = db.collection("users").document(uid)
            
            do {
                let documentSnapshot = try await userDocument.getDocument()
                
                if let documentData = documentSnapshot.data(), let favorites = documentData["favorites"] as? [String] {
                    print(favorites)
                   return favorites
                } else {
                    return []
                }
            } catch {
                print("Ошибка Firestore: \(error.localizedDescription)")
            }
        }
        return []
    }

}
