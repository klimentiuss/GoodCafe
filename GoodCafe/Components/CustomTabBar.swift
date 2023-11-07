//
//  TabBarView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI


enum Tab: String, CaseIterable {
    case house
    case list
    case favorite
    case profile
    case cart
}

struct CustomTabBar: View {
    
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                HStack {
                    Button {
                        selectedTab = .house
                    } label: {
                        Image(systemName: "house.fill")
                    }
                    .foregroundColor( selectedTab == .house ? .black : .gray)
                    
                    Spacer()
                    
                    Button {
                        selectedTab = .list
                    } label: {
                        Image(systemName: "list.dash")
                    }
                    .foregroundColor( selectedTab == .list ? .black : .gray)
                    
                    Spacer()
                    
                    Button {
                        selectedTab = .favorite
                    } label: {
                        Image(systemName: "star.fill")
                    }
                    .foregroundColor( selectedTab == .favorite ? .black : .gray)
                    
                    Spacer()
                    
                    Button {
                        selectedTab = .profile
                    } label: {
                        Image(systemName: "person.fill")
                    }
                    .foregroundColor( selectedTab == .profile ? .black : .gray)
                }
                .padding()
                .padding(.horizontal, 22)
                .background(Color.white)
            
                Button {
                    selectedTab = .cart
                } label: {
                    Image(systemName: "cart")
                        .renderingMode(.original)
                        .padding(15)
                }
                .background(Color.black)
                .clipShape(Circle())
                .offset(y: -32)
                .shadow(radius: 3)
                .tint(.white)

            }
             
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.house))
    }
}


