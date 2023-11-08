//
//  FavoriteProductsViewModel.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import Foundation

@MainActor
class FavoriteProductsViewModel: ObservableObject {
    
    @Published var faforiteProducts: [Product] = []
    @Published var favoriteString: [String] = []
    
    func getProducts(faforiteProductNames: [String]) async {
        
        var list: [Product] = []
        
        do {
            let beverages = try await NetworkManager.shared.getProducts(from: APIConstants.beveragesStringURL)
            let desserts = try await NetworkManager.shared.getProducts(from: APIConstants.dessertsStringURL)
            
            list = beverages + desserts
            
            faforiteProducts = list.filter { product in
                return faforiteProductNames.contains(product.name)
            }
            
            
            print(faforiteProducts.count)
            
        } catch {
            print(error.localizedDescription)
        }
    }

}
