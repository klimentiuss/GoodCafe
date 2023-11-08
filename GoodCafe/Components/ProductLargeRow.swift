//
//  ProductLargeRow.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct ProductLargeRow: View {
    
    let product: Product
    var completion: () -> ()
    
    @EnvironmentObject var authManager: FireBaseManager
    @State private var isFavorite: Bool = false
    
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: screenSize().width - 50, height: screenSize().height / 1.7)
                .foregroundColor(.white)
                .overlay {
                    ZStack {
                        ImageView(imageStringURL: product.image)
                            .offset(y: -20)
                            .scaledToFill()
                            .frame(width: 300, height: 340)
                            .clipped()
                        VStack(alignment: .center) {
                            Spacer()
                            HStack {
                                Text(product.name)
                                    .font(.system(size: screenSize().width <= 375 ? 18 : 20))
                                    .bold()
                                    .opacity(0.8)
                                
                                Button {
                                    completion()
                                } label: {
                                    Image(systemName: "info.circle")
                                }
                                .tint(.black)
                                
                            }
                            .frame(width: 250)
                        }
                        .padding(.bottom, 15)
                        
                        
                        HStack {
                            VStack {
                                HStack {
                                    HStack {
                                        Text("\(product.price)")
                                            .bold()
                                            .font(.system(size: 20))
                                            .padding(.trailing, -8)
                                        Text("$")
                                            .opacity(0.5)
                                            .font(.system(size: 14))
                                    }
                                    Spacer()
                                    Button {
                                        isFavorite.toggle()
                                        Task {
                                            await authManager.addStringToFavorites(favoriteString: product.name)
                                        }
                                    } label: {
                                        Image(systemName: isFavorite ? "star.fill" : "star")
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding()
                                Spacer()
                            }
                        }
                    }
                }
            
        }
        .onAppear {
            Task {
                await isFavorite = authManager.areFavoritesEqual(favoritesToCompare: product.name)
            }
        }
        
    }
    
    
}
struct ProductLargeRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductLargeRow(product: Product.example){}
    }
}
