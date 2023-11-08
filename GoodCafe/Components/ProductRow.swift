//
//  ProductRow.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct ProductRow: View {
    
    @EnvironmentObject var authManager: FireBaseManager
    @State private var isFavorite: Bool = false
    let product: Product
    var completion: ()->()
    
    var body: some View {
   
            VStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: screenSize().width - 50, height: 300)
                    .foregroundColor(.white)
                    .overlay {
                        ZStack {
                            ImageView(imageStringURL: product.image)
                                .offset(y: -20)
                                .aspectRatio(contentMode: .fit)
                            VStack {
                                Spacer()
                                Text(product.name)
                                    .font(.system(size: 25))
                                    .bold()
                                    .opacity(0.8)
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
                        .overlay {
                            Button {
                                completion()
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.top, 280)
                            .padding(.leading, screenSize().width - 50)
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

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product.example){}
    }
}
