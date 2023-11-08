//
//  BeverageListView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject private var viewModel = ProductListViewModel()
    @State private var isAlertShown = false
    
    var category: Category
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.pink)
                .opacity(0.5)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(viewModel.products, id: \.self) { product in
                        ProductRow(product: product) {
                            CartManager.shared.addProduct(product: product)
                            isAlertShown.toggle()
                        }
                        
                    }
                }
                .scrollIndicators(.hidden)
                .frame(width: screenSize().width)
            }
            .alert("Product has been added to the cart!", isPresented: $isAlertShown) {
                Button("Ok", role: .cancel) {}
            }
            .onAppear {
                viewModel.getTitle(by: category)
                Task {
                   await viewModel.getProducts(by: category)
                }
            }
            
        }
        .navigationTitle(viewModel.title)
        
        
        
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(category: .beverages)
    }
}
