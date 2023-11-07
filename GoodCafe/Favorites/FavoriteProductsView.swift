//
//  FavoriteProductsView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct FavoriteProductsView: View {
    
    @EnvironmentObject var authManager: AuthentificationManager
    @StateObject private var viewModel = FavoriteProductsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.faforiteProducts, id: \.self ) { product in
                    ProductRow(product: product) {
                        Task {
                            await viewModel.favoriteString = authManager.getFavorites()
                            await viewModel.getProducts(faforiteProductNames: viewModel.favoriteString)
                        }
                    }
                }
            }
        }
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
