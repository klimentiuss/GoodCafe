//
//  CartManager.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 08.11.2023.
//

import SwiftUI

class CartManager {
    
    static let shared = CartManager()
    
    @AppStorage("cartItems") var cartItemsData: Data?
    @Published var cartItems: [Product] = [] {
        didSet {
            saveCartItems()
        }
    }
    
    init() {
        loadCartItems()
    }

    func addProduct(product: Product) {
        cartItems.append(product)
        print(cartItems)
    }

    func removeProduct(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.name == product.name }) {
            cartItems.remove(at: index)
        }
        print(cartItems)
    }

    private func saveCartItems() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(cartItems) {
            UserDefaults.standard.set(encodedData, forKey: "cartItems")
        }
    }

    private func loadCartItems() {
        if let cartItemsData = cartItemsData {
            let decoder = JSONDecoder()
            if let decodedItems = try? decoder.decode([Product].self, from: cartItemsData) {
                cartItems = decodedItems
            }
        }
        print(cartItems)
    }
}
