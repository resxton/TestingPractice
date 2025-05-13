//
//  Coffee.swift
//  DemoAppForTests
//
//  Created by Dmitriy Toropkin on 05.05.2025.
//

import Foundation

struct Coffee: Codable {
    let id: Int
    let name: String
    let price: Double
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, price
        case imageURL = "image_url"
    }
}
