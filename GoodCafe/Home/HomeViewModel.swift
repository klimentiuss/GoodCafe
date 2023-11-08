//
//  HomeViewModel.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var isInfoShown = false
    
    func getProducts() async {
        do {
            products = try await NetworkManager.shared.getProducts(from: APIConstants.bestProducts)
        } catch {
            
        }
        
         
    }
    
}
