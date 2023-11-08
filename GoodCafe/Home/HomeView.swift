//
//  HomeView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import SwiftUI

struct HomeView: View {
        
    @EnvironmentObject var authManager: FireBaseManager
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var currentIndex: Int = 0
    @State private var isAlertShown = false
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Make your day sweet:")
                .font(.title3)
                .foregroundColor(.white)
            VStack {
                ZStack {
                    ForEach(0..<viewModel.products.count, id: \.self) { index in
                        ProductLargeRow(product: viewModel.products[index]) {
                            viewModel.isInfoShown.toggle()
                        }
                        .overlay {
                            ZStack {
                                if viewModel.products[index].price == 12 {
                                    Sticker()
                                        .offset(x: -80, y: -100)
                                }
                                
                                CustomButton(currentIndex: currentIndex, productIndex: index, heightIndex: 1.8, widthIndex: 50) {
                                    CartManager.shared.addProduct(product: viewModel.products[index])
                                    isAlertShown.toggle()
                                }
                            }
                            
                        }
                        .scaleEffect( currentIndex == index ? 1 : 0.8)
                        .offset(x: CGFloat(index - currentIndex) * screenSize().width / 1.25 )
                    }
                    
                    
                }
                .onTapGesture {
                    viewModel.isInfoShown.toggle()
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
            .alert("Product has been added to the cart!", isPresented: $isAlertShown) {
                Button("Ok", role: .cancel) {}
            }
            Spacer()
        }
        .sheet(isPresented: $viewModel.isInfoShown, content: {
            InfoView(description: viewModel.products[currentIndex].description)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.25), .medium])
        })
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
