//
//  HomeView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct HomeView: View {
    
   
    
    
    @EnvironmentObject var authManager: AuthentificationManager
    
    @State private var currentIndex: Int = 0
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Make your day sweet:")
                .font(.title3)
                .foregroundColor(.white)
            VStack {
                ZStack {
                    ForEach(0..<viewModel.products.count, id: \.self) { index in
                        ProductLargeRow(product: viewModel.products[index]) {
                            print("kek")
                        }
                            .overlay {
                                ZStack {
                                    
                                    if viewModel.products[index].price == 12 {
                                        Sticker()
                                            .offset(x: -80, y: -100)
                                    }
                                    
                                    Button {
                                        print(viewModel.products[index].name)
                                    } label: {
                                        if currentIndex == index {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 40, height: 40)
                                                    .foregroundColor(.black)
                                                Image(systemName: "plus")
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        
                                    }
                                    .padding(.top, screenSize().height - 380)
                                    .padding(.leading, screenSize().width - 50)
                                }
                                
                                
                            }
                            .scaleEffect( currentIndex == index ? 1 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * screenSize().width / 1.25 )
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(viewModel.products.count - 1, currentIndex + 1)
                                }
                            }
                        })
                )
            }
            .padding(.top, 20)
            Spacer()
            
            
            
            
        }
        .onAppear {
            Task {
                await viewModel.getProducts()
            }
        }
        .navigationTitle("Welcome")
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
