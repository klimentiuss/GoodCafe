//
//  ProductListViewModel.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var title = ""
    
    
    func getProducts(by category: Category) async {
        
        var url = ""
        
        switch category {
        case .beverages:
            url = APIConstants.beveragesStringURL
        case .desserts:
            url = APIConstants.dessertsStringURL
        }
        
        do {
            products = try await NetworkManager.shared.getProducts(from: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
   func getTitle(by category: Category) {
       switch category {
           
       case .beverages:
           title = "Beverages"
       case .desserts:
           title = "Desserts"
       }
    }
}
