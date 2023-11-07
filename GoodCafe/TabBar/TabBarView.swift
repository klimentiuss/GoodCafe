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
    
    var body: some View {
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
                    Text("123")
                }
                
                CustomTabBar(selectedTab: $tabSelected)
                
            }
        }
        }
        
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
