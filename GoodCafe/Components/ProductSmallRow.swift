//
//  ProductSmallRow.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 08.11.2023.
//

import SwiftUI

struct ProductSmallRow: View {
    
    @State private var isFavorite: Bool = false
    let product: Product
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: screenSize().width - 50, height: 100)
                .foregroundColor(.white)
                .overlay {
                    HStack {
                        ImageView(imageStringURL: product.image)
                            .scaledToFill()
                            .frame(width: 100, height: 100) 
                            .clipped()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                        
                        Text(product.name)
                            .font(.system(size: 17))
                            .bold()
                            .opacity(0.8)
                            .frame(width: 140)
                        
                        Spacer()
                        
                        HStack {
                            Text("\(product.price)")
                                .bold()
                                .font(.system(size: 25))
                                .padding(.trailing, -8)
                            Text("$")
                                .opacity(0.5)
                                .font(.system(size: 14))
                        }
                        .frame(width: 50)
                        
                        
                        
                        Spacer()
                    }
                }
        }
    }
}

struct ProductSmallRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductSmallRow(product: Product.example)
    }
}
