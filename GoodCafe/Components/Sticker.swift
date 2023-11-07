//
//  Sticker.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct Sticker: View {
    
    @State private var rotation: CGFloat = 0
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.pink)
                .opacity(0.3)
                .frame(width: 70, height: 70)
                .overlay {
                    Text("Choise of the day")
                        .frame(width: 55)
                        .multilineTextAlignment(.center)
                        .bold()
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .italic()
                }
            Circle()
                .stroke(lineWidth: 4)
                .frame(width: 74, height: 74)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red,.green,.purple, .cyan]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
        }
        .rotationEffect(.degrees(15))
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

struct Sticker_Previews: PreviewProvider {
    static var previews: some View {
        Sticker()
    }
}
