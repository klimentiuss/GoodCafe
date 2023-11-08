//
//  CustomButton.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 08.11.2023.
//

import SwiftUI

struct CustomButton: View {
    
    var currentIndex: Int
    var productIndex: Int
    var heightIndex: Double
    var widthIndex: Double
    var completion: () -> ()
    
    
    var body: some View {
        Button {
            completion()
        } label: {
            if currentIndex == productIndex {
                ZStack {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
            }
            
        }
        .padding(.top, screenSize().height / heightIndex)
        .padding(.leading, screenSize().width - widthIndex)
    }
}

//struct CustomButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomButton(){}
//    }
//}
