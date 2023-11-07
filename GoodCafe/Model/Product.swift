//
//  Menu.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import Foundation


struct Product: Codable, Hashable {
    var id: Int
    var name: String
    var image: String
    var description: String
    var price: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "img"
        case description = "desc"
        case price
    }
}


extension Product {
    static var example: Product {
        return Product(
            id: 1,
            name: "Good beverage",
            image: "https://s7d1.scene7.com/is/image/mcdonalds/t-mcdonalds-Dr-Pepper-Small-1:product-header-mobile?wid=768&hei=441&dpr=off",
            description: "This is a Good beverage",
            price: 5
        )
    }
}
