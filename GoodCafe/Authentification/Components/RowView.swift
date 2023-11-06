//
//  RowView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import SwiftUI

struct RowView: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
    }
}
