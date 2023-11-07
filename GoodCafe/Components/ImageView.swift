//
//  ImageView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct ImageView: View {
    let imageStringURL: String

    var body: some View {
        
        if let imageURL = URL(string: imageStringURL) {
            AsyncImage(url: imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                } else if phase.error != nil {
                    Text("Error loading")
                } else {
                    ProgressView()
                }
            }
        }
        
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
