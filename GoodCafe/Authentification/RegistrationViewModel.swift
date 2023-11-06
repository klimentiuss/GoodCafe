//
//  RegistrationViewModel.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import Foundation


class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    @Published var confirmPassword = ""
}
