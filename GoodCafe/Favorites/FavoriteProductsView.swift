//
//  FavoriteProductsView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct FavoriteProductsView: View {
    
    @EnvironmentObject var authManager: FireBaseManager
    @StateObject private var viewModel = FavoriteProductsViewModel()
    @State private var isAlertShown = false
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.faforiteProducts, id: \.self ) { product in
                    ProductRow(product: product) {
                        CartManager.shared.addProduct(product: product)
                        isAlertShown.toggle()
                    }
                    
                }
                
            }
            .padding(.bottom, 60)
            .frame(width: screenSize().width)
        }
        .alert("Product has been added to the cart!", isPresented: $isAlertShown) {
            Button("Ok", role: .cancel) {}
        }
        .scrollIndicators(.hidden)
        .onAppear {
            Task {
                await viewModel.favoriteString = authManager.getFavorites()
                await viewModel.getProducts(faforiteProductNames: viewModel.favoriteString)
            }
        }
        .navigationTitle("Favorites")
    }
}

struct FavoriteProductsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteProductsView()
    }
}
