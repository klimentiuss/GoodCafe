//
//  ProductSelectionView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

enum Category: String, CaseIterable {
    case beverages = "cup.and.saucer"
    case desserts = "fork.knife"
}

struct CategorySelectionView: View {
    
    var body: some View {
        VStack {
                ForEach(Category.allCases, id: \.self) { category in
                    NavigationLink {
                        ProductListView(category: category)
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: screenSize().width / 1.2, height: screenSize().height / 3.3)
                            .foregroundColor(.white)
                            .foregroundColor(.white)
                            .overlay {
                                Image(systemName: category.rawValue)
                                    .resizable()
                                    .frame(width: 90, height: 80)
                            }
                            .tint(.black)
                    }
                }
                Spacer()
        }
        .padding()
        .navigationTitle("Choose")
    }
}


struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectionView()
    }
}
