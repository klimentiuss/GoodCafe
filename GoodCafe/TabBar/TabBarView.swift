//
//  SwiftUIView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @State private var tabSelected: Tab = .house
    @State private var showSecondView = false
    
    var body: some View {
        if !showSecondView {
            ProgressView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            showSecondView = true
                        }
                    }
                }
        } else {
            NavigationView {
                ZStack {
                    Rectangle()
                        .foregroundColor(.pink)
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    
                    switch tabSelected {
                    case .house:
                        HomeView()
                    case .list:
                        CategorySelectionView()
                    case .favorite:
                        FavoriteProductsView()
                    case .profile:
                        ProfileView()
                    case .cart:
                        CartView()
                    }
                    
                    CustomTabBar(selectedTab: $tabSelected)
                    
                }
            }
        }
        
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
