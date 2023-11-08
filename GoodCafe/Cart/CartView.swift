//
//  CartView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 08.11.2023.
//

import SwiftUI

struct CartView: View {
    
    @State var list: [Product] = []
    
    var body: some View {
        List {
            if list.count > 0 {
                ForEach(list, id: \.self) { product in
                    ProductSmallRow(product: product)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        print(index)
                    CartManager.shared.removeProduct(product: list[index])
                    }
                }
            } else {
                Text("The cart is empty :c")
            }
            
        }
        .scrollContentBackground(.hidden)
        .onAppear {
            list = CartManager.shared.cartItems
        }
        .navigationTitle("Cart")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
