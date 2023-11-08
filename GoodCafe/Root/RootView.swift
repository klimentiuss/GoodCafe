//
//  ContentView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import SwiftUI



struct RootView: View {
    
    @EnvironmentObject var authManager: FireBaseManager

    var body: some View {
        Group {
            if authManager.userSession != nil {
                TabBarView()
            } else {
                LoginView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
