//
//  LoginViewModel.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import Foundation


class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
}
