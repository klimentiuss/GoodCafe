//
//  GoodCafeApp.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import SwiftUI
import FirebaseCore

@main
struct GoodCafeApp: App {
    
    @StateObject var authorizationManager = AuthentificationManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authorizationManager)
                .preferredColorScheme(.light)
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
}
